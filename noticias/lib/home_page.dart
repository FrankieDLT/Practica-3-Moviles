import 'package:flutter/material.dart';
import 'package:noticias/buscar/buscar.dart';
import 'package:noticias/noticias/noticias.dart';

import 'mis noticias/creadas/mis_noticias.dart';
import 'mis noticias/nuevo/crear_noticia.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final _pagesList = [
    Noticias(),
    Buscar(),
    MisNoticias(),
    CrearNoticia(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.cyan,
        selectedItemColor: Colors.purple,
        currentIndex: _currentPageIndex,
        onTap: (index){
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.class_,
            ),
            label: "Noticicas",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmarks,
            ),
            label: "Mis Noticias Creadas",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subject,
            ),
            label: "Agregar Noticias",
          ),
        ],
      ),
    );
  }
}
