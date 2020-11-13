import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';
import 'package:noticias/noticias/item_noticia.dart';

class MisNoticias extends StatefulWidget {
  const MisNoticias({Key key}) : super(key: key);

  @override
  _MisNoticiasState createState() => _MisNoticiasState();
}

class _MisNoticiasState extends State<MisNoticias> {
  MisNoticiasBloc _misnotBloc;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider<MisNoticiasBloc>(
        create: (context) {
          _misnotBloc = MisNoticiasBloc()..add(LeerNoticiasEvent());
          return _misnotBloc;
        },
        child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
          listener: (context,state) {
            if(state is NoticiasErrorState){
                _showMessage(context, "${state.errormessage}"); 
            }
          },
           builder: (context, state) {
             if(_misnotBloc.noticiaList != null){
             
              return Scaffold(
       body: ListView.builder(
         itemCount: _misnotBloc.noticiaList != null
                  ? _misnotBloc.noticiaList.length
                  : 0,
         itemBuilder: (BuildContext context, int index) {
           return ItemNoticia(noticia: _misnotBloc.noticiaList[index] );
         },
         )
    );
           } else {
             return Center(
               child: Container(
                 child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          _misnotBloc.add(LeerNoticiasEvent());
                        });
                      },
                      child: Text("Recargar datos"),
                      color: Colors.cyanAccent[600],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
               ),
             );
           }


           },
        )
        ),
    );
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