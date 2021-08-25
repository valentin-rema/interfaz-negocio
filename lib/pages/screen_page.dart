import 'package:after_layout/after_layout.dart';
import 'package:app_locales/libs/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 25.0)
      )
    );        
  }

  @override
  void afterFirstLayout(BuildContext context) async {

    await Firebase.initializeApp();
    //vamos a comenzar
    final datosUsuario = Auth.instance.datosUsuario;

    //ahora vamos con las condicionales
    if(datosUsuario != null){
      print(datosUsuario.photoURL);
      Navigator.pushReplacementNamed(context, 'home');
    }
    if(datosUsuario == null){
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}


//vamos a colocar el page que me va a indicar que estamos verificando el logeo