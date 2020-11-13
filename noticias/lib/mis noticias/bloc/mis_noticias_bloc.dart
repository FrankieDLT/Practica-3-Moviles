import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noticias/models/noticia.dart';
import 'package:path/path.dart' as Path;

part 'mis_noticias_event.dart';
part 'mis_noticias_state.dart';

class MisNoticiasBloc extends Bloc<MisNoticiasEvent, MisNoticiasState> {
  List<Noticia> noticiaList;
  List<Noticia> get listaNoticias => noticiaList;
  File chosenImage;
  MisNoticiasBloc() : super(MisNoticiasInitial());

  @override
  Stream<MisNoticiasState> mapEventToState(
    MisNoticiasEvent event,
  ) async* {
    print(event);
    // TODO: implement mapEventToState
    if (event is LeerNoticiasEvent) {
      try {
        await _getAllNoticias();
        print("PASO GETALL****************");
        yield NoticiasDescargadasState();
      } catch (e) {
        yield NoticiasErrorState(errormessage: "No se pudieron cargar las noticias");
      }
    } else if (event is CargarImagenEvent) {
      //
       chosenImage = await _chooseImage(event.camera);
      //IF DIFERENTE DE NULL
      yield ImagenCargadaState(imagen: chosenImage);
    } else if (event is CrearNoticiasEvent) {
      //
      try {
        String imageUrl = await _uploadPicture(chosenImage);
        await _saveNoticia(
          event.titulo,
          event.descripcion,
          event.autor,
          event.fuente,
          imageUrl,);
          yield NoticiasCreadaState();
      } catch (e) {
        yield NoticiasErrorState(
          errormessage: "No se pudo guardar noticia"
        );
      }
    }
  }
//Subir imagen al bucket de almacenamiento
Future<String> _uploadPicture(File image) async {
    String imagePath = image.path;
    // referencia al storage de firebase
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("noticias/${Path.basename(imagePath)}");

    // subir el archivo a firebase
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;

    // recuperar la url del archivo que acabamos de subir
    dynamic imageURL = await reference.getDownloadURL();
    return imageURL;
  }

  Future _getAllNoticias() async {
    // recuperar lista de docs guardados en Cloud firestore
    // mapear a objeto de dart (Apunte)
    // agregar cada ojeto a una lista
    
    var misnoticias = await FirebaseFirestore.instance.collection("noticias").get();
    print("PASÓ GET");
    noticiaList = misnoticias.docs.map(
          (elemento) => Noticia(
            title: elemento["title"],
            description:  elemento["description"],
            author: elemento["author"],
            source: elemento["fuente"],
            urlToImage: elemento["urlToImage"], 
            publishedAt: elemento["publishedAt"],
          ),
        ).toList();

        print("Noticias");

  }
  
  Future<File> _chooseImage(bool fromcamera) async {
    final picker = ImagePicker();
    final PickedFile chooseImage = await picker.getImage(
      source:fromcamera ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    return File(chooseImage.path);
  }
  //Guardar elemento en Firestore
  Future _saveNoticia(
    String titulo,
    String descripcion,
    String autor,
    String fuente,
    String imageUrl,
  ) async {
    // Crea un doc en la collection de apuntes

    await FirebaseFirestore.instance.collection("noticias").doc().set({
      "title": titulo,
      "description": descripcion,
      "author": autor,
      "fuente": fuente,
      "urlToImage": imageUrl,
      "publishedAt": DateTime.now().toString(),
    });
  }
  

}
