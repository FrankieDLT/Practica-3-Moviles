import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noticias/home_page.dart';
import 'package:noticias/login/login_page.dart';
 
void main() async{
  //Inicializando Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginPage(),//  HomePage(),
    );
  }
}