
//vamos a comenzar con el home page
import 'package:app_locales/libs/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final datosUsuario = Auth.instance.datosUsuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              //ahora vamos a colocar una imagen
              CircleAvatar(
                backgroundColor: Color(0xff4527A0),
                radius: 40.0,
                child: Container(
                  width: 75.0,
                  height: 75.0,
                  child: (datosUsuario.photoURL != null)
                          ? pintarImagen()
                          : Center(
                            child: pintarOvalo(),
                          )
                  )
                ),
              Text(datosUsuario.displayName, style: TextStyle(fontFamily: 'sans', fontWeight: FontWeight.bold, fontSize: 20.0)),
              //SizedBox(height: 5.0),
              Text(datosUsuario.email, style: TextStyle(fontFamily: 'sans', fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.black38)),
              FlatButton(
                child: Icon(Icons.exit_to_app, size: 40.0),
                onPressed: (){
                  //me presionaron  
                  Auth.instance.logOut(context); 
                },
              )
            ],
          ),
        ),
      )
    );
  }


  //metodo para pintar el circular Avatar
  Widget pintarImagen(){
    return ClipOval(
      child: Image.network(
        datosUsuario.photoURL, 
        fit: BoxFit.cover
      ),
    );
  }

  Widget pintarOvalo(){
    //vamos a comenzar
    final separador = this.datosUsuario.displayName.split(" ");

    print(separador);
    //ahora vamos con la lista del String
    final iniciales = [];

    iniciales.add(separador[0].substring(0,1));

    iniciales.add(separador[1].substring(0,1));

    return Text('${iniciales[0]}${iniciales[1]}', 
      style: TextStyle(
        color: Colors.white, 
        fontWeight: FontWeight.bold,
        fontSize: 30.0
      ));

  }

}

//vamos a continuar con el curso entonces manos a la obrq vamos a mostrar los datos del usuario