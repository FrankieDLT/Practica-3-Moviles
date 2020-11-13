import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/models/noticia.dart';
import 'package:noticias/noticias/bloc/noticias_bloc.dart';
import 'package:noticias/noticias/noticia_deportes.dart';
import 'package:noticias/noticias/noticia_negocios.dart';

class Buscar extends StatefulWidget {
  Buscar({Key key}) : super(key: key);

  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  TextEditingController _busquedaController = TextEditingController();
  List<Noticia> _listOfFilteredSportsNews;
  List<Noticia> _listOfFilteredBuisnessNews;
  final _tabsList = [
    Tab(icon: Icon(Icons.article), text: "Deportes"),
    Tab(icon: Icon(Icons.description), text: "Negocios"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        appBar: AppBar(
          title: Text("Busqueda de Noticias"),
          bottom: TabBar(
            tabs: _tabsList,
          ),
        ),
        body: Center(
          child: BlocProvider(
            create: (context) => NoticiasBloc()..add(GetNewsEvent()),
            child: BlocConsumer<NoticiasBloc, NoticiasState>(
              listener: (context, state) {
                // DONE: implement listener
              },
              builder: (context, state) {
               
                if (state is NoticiasSuccessState) { 
                   if(_listOfFilteredSportsNews==null){
                  _listOfFilteredSportsNews = state.noticiasSportList;
                  _listOfFilteredBuisnessNews = state.noticiasBuisnessList;
                  }
                  
                  return Column(
                    children: [
                      TextField(
                        controller: _busquedaController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Buscar Noticias",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          //Filtrado de noticias
                          setState(() {
                            //Deportes
                            if (_busquedaController.text == "") {
                              _listOfFilteredSportsNews = state.noticiasSportList;
                            } else {
                              _listOfFilteredSportsNews =
                                  state.noticiasSportList.where(
                                (news) {
                                return  news.title
                                      .toLowerCase()
                                      .contains(_busquedaController.text);
                                },
                              ).toList();
                            }
                            
                            //Negocios
                            if (_busquedaController.text == "") {
                              _listOfFilteredBuisnessNews = state.noticiasBuisnessList;
                            } else {
                              _listOfFilteredBuisnessNews =
                                  state.noticiasBuisnessList.where(
                                (news) {
                                 return news.title
                                      .toLowerCase()
                                      .contains(_busquedaController.text);
                                },
                              ).toList();
                            }

                          });
                        },
                      ),
                      Expanded(
                                              child: SizedBox(
                          height: 200.0,
                          child: TabBarView(
                            children: [
                              NoticiaDeportes(
                                noticias: _listOfFilteredSportsNews,//state.noticiasSportList,
                              ),
                              NoticiaNegocio(
                                noticias: _listOfFilteredBuisnessNews,//state.noticiasBuisnessList,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text("No hay noticias disponibles"),
                );
              },
            ),
          ),
        )),
        );
  }

  _filterNews() {
  }
}
