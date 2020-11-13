import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/auth/user_auth_provider.dart';
import 'package:noticias/home_page.dart';
import 'package:noticias/noticias/bloc/noticias_bloc.dart';
import 'package:noticias/noticias/noticia_deportes.dart';
import 'package:noticias/noticias/noticia_negocios.dart';

class Noticias extends StatefulWidget {
  Noticias({Key key}) : super(key: key);

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  // final _noticiasContentList = [NoticiaDeportes(), NoticiaNegocio()];
  final _tabsList = [
    Tab(icon: Icon(Icons.article), text: "Deportes"),
    Tab(icon: Icon(Icons.description), text: "Negocios"),
  ];
  UserAuthProvider _authProvider = UserAuthProvider();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Noticias de la Semana"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                setState(() {//Cierra sesion pero no manda al incio
                  _authProvider.signOutGoogle();
                  _authProvider.signOutFirebase();
                });
              },
              child: Text(""),//LOGOUT
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
          bottom: TabBar(
            tabs: _tabsList,
          ),
        ),
        body: BlocProvider(
          create: (context) => NoticiasBloc()..add(GetNewsEvent()),
          child: BlocConsumer<NoticiasBloc, NoticiasState>(
            listener: (context, state) {
              // DONE: implement listener
            },
            builder: (context, state) {
              if (state is NoticiasSuccessState) {
                return TabBarView(
                  children: [
                    NoticiaDeportes(
                      noticias: state.noticiasSportList,
                    ),
                    NoticiaNegocio(
                      noticias: state.noticiasBuisnessList,
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
      ),
    );
  }
}
