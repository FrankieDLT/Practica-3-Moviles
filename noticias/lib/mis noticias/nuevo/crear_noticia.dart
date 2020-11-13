import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';

class CrearNoticia extends StatefulWidget {
  CrearNoticia({Key key}) : super(key: key);

  @override
  _CrearNoticiaState createState() => _CrearNoticiaState();
}

//TODO: Formulario para crear noticias
//tomar foto de camara o de la galeria
class _CrearNoticiaState extends State<CrearNoticia> {
  MisNoticiasBloc _misnotBloc;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _fuenteController = TextEditingController();
  bool _imagenTomada = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Crear una Noticia"),
        ),
        body: BlocProvider<MisNoticiasBloc>(
          create: (context) {
            _misnotBloc = MisNoticiasBloc();
            print(_misnotBloc.noticiaList);
            return _misnotBloc;
          },
          child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
              listener: (context, state) {
            if (state is NoticiasErrorState) {
              _showMessage(context, "${state.errormessage}");
            }
          }, builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            _misnotBloc.add(CargarImagenEvent(camera: true));
                          if(_misnotBloc.chosenImage!=null){
                            _imagenTomada = true;
                          }
                          });
                        },
                        child: Icon(Icons.camera_alt),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            _misnotBloc.add(CargarImagenEvent(camera: false));
                           if(_misnotBloc.chosenImage!=null){
                            _imagenTomada = true;
                          }
                          });
                        },
                        child: Icon(Icons.camera_roll),
                      ),
                      Text(_imagenTomada == false
                      ? "Imagen No tomada Aun"
                      : "Imagen tomada" ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      maxLines: 2,
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Titulo de la Noticia",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _authorController,
                      decoration: InputDecoration(
                        hintText: "Nombre del autor",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _fuenteController,
                      decoration: InputDecoration(
                        hintText: "Fuente de la Noticia",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: "Descripción de la Noticia",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_titleController.text == "" ||
                          _descriptionController.text == "" ||
                          _authorController.text == "" ||
                          _fuenteController.text == "" ||
                          _misnotBloc.chosenImage == null) {
                        //Algun campo Vacio
                        Scaffold.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text("No deje campos vacios"),
                            ),
                          );
                      } else {
                        //CrearNoticiasEvent
                        Scaffold.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text("SUCCESS"),
                            ),
                          );

                        _misnotBloc.add(CrearNoticiasEvent(
                            titulo: _titleController.text,
                            descripcion: _descriptionController.text,
                            autor: _authorController.text,
                            fuente:  _fuenteController.text,
                            ));

                           setState(() {
                              _titleController.text = null;
                          _descriptionController.text = null;
                          _authorController.text = null;
                          _fuenteController.text = null;
                          _misnotBloc.chosenImage = null;
                          _imagenTomada = false;
                           });
                      }
                    },
                    child: Text("Crear Noticia"),
                    color: Colors.cyanAccent[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    ));
  }

  void _showMessage(BuildContext context, String message) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("$message"),
        ),
      );
  }
}
