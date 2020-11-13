import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:noticias/models/noticia.dart';
import 'package:noticias/secrets.dart';

part 'noticias_event.dart';
part 'noticias_state.dart';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasState> {
 final _sportsLink = "https://newsapi.org/v2/top-headlines?country=mx&category=sports&$apiKey";
 final _businessLink = "https://newsapi.org/v2/top-headlines?country=mx&category=business&$apiKey";
  NoticiasBloc() : super(NoticiasInitial());

  @override
  Stream<NoticiasState> mapEventToState(
    NoticiasEvent event,
  ) async* {
    if(event is GetNewsEvent){
     
     try {
        List<Noticia> sportNews = await _requestNoticiasSport();
        List<Noticia> buisnessNews =await _requestNoticiasBuisness();
        yield NoticiasSuccessState(
          noticiasBuisnessList: buisnessNews,
          noticiasSportList: sportNews,
        );
      } catch (e) {
        yield NoticiasErrorState(messege: "Error al cargar la noticias: $e");
      }
    }
  }

  Future <List<Noticia>>_requestNoticiasSport()async{
      Response response = await get(_sportsLink);
      List<Noticia> _noticiasList = List();

      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList = 
        ((data).map((el) => Noticia.fromJson(el))).toList();
      }
      return _noticiasList;
  }

  Future <List<Noticia>>_requestNoticiasBuisness()async{
      Response response = await get(_businessLink);
      List<Noticia> _noticiasList = List();

      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body)["articles"];
        _noticiasList = 
        ((data).map((el) => Noticia.fromJson(el))).toList();
      }
      return _noticiasList;
  }
}
