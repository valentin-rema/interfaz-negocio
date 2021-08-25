//vamos a comenzar con la creacion de la aplicaion movil primero para la parte de las empresas
//y locales afiliados asi que sin mas vamos a comenzar

import 'package:app_locales/pages/home_page.dart';
import 'package:app_locales/pages/login.dart';
import 'package:app_locales/pages/screen_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Empresa TM',
      //vamos comenzar a definir las cosas
      initialRoute: 'screen',
      routes: {
        //vamos a colocar las rutas que vamos a necesitar
        'login' : ( _ ) => Encabezado(),
        'screen': ( _ ) => ScreenPage(),
        'home'  : ( _ ) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'sans'
      ),
    );
  }
}
