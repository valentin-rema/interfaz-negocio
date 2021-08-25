import 'package:app_locales/dialogs/pintar_dialog.dart';
import 'package:app_locales/extras/extras.dart';
import 'package:app_locales/libs/auth.dart';
import 'package:app_locales/utils/responsive.dart';
import 'package:app_locales/widgets/login/botones/boton-login.dart';
import 'package:app_locales/widgets/login/botones/boton_redes.dart';
import 'package:app_locales/widgets/login/inputs/text_inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class FormAcceso extends StatefulWidget {

  //variables de inicializacion
  final VoidCallback cambiandoRegistro;
  final VoidCallback forgotPassword;


  const FormAcceso({
    @required this.cambiandoRegistro,
    @required this.forgotPassword
  }); 

  @override
  _FormAccesoState createState() => _FormAccesoState();
}

class _FormAccesoState extends State<FormAcceso> {

  final GlobalKey<InputTextState> emailKey = GlobalKey();
  final GlobalKey<InputTextState> passwordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final Responsive responsiva = Responsive.of(context);
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Container(
            width: responsiva.pan(90),
            //color: Colors.red,
            //height: 200.0,
            //vamos a colocar la parte del form
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //vamos a colocar a los inputs text de forma dinamica
                  InputText(
                    key: emailKey,
                    textoD: 'Correo Electronico', 
                    pathImagen: 'assets/email.svg',
                    validator: (valor){
                      //ahora vamos con el retorno 
                        return Extras.isValidEmail(valor);
                    }
                  ),
                  SizedBox(height: responsiva.phi(2.5)),
                  InputText(
                    key: passwordKey,
                    textoD: 'Contraseña', 
                    pathImagen: 'assets/pass.svg',
                    esconder: true,
                    validator: (texto){
                      return texto.trim().length >= 6;
                    }
                  ),
                  //ahora vamos a crear el boton para acceder
                  Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      child: Text('Olvido su contraseña?', style: TextStyle(fontFamily: 'sans', color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                      onPressed: (){
                        //cuando presionemos
                        this.widget.forgotPassword();
                      },
                    ),
                  ),
                  SizedBox(height: responsiva.phi(2)),
                  BotonAcceder(
                    onPress: _submit, 
                    label: 'Acceder'
                  ),
                  //ahora vamos a colocar un texto
                  Text('Siguenos en nuestras redes sociales', style: TextStyle(fontFamily: 'sans', fontSize: 14)),
                  //vamos colocar los botones
                  //vamos a colocar el boton
                  SizedBox(height: responsiva.phi(3.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BotonesRedes(size: 60, path: 'assets/facebook.svg', onPress: () async {
                          final usuario = await Auth.instance.facebook(context);
                          //vamos a ver si retornamos algo
                          if(usuario != null){
                            Navigator.pushReplacementNamed(context, 'home');
                          }else{
                            print('Fallo el logeo');
                          }
                      },),
                      SizedBox(width: 25),
                      BotonesRedes(size: 60, background: Color(0xffEC407A), path: 'assets/instagram.svg', onPress: () async{
                          final usuario = await Auth.instance.google(context);
                          
                          //vamos a ver si retornamos algo
                          if(usuario != null){
                            Navigator.pushReplacementNamed(context, 'home');
                          }else{
                            print('Fallo el logeo');
                          }
                      },)
                    ]
                  ),
                  //anuncio de que si no tenemos una cuenta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No tienes una cuenta', style: TextStyle(fontFamily: 'sans', fontSize: 17.0)),
                      CupertinoButton(
                        child: Text('Pulsa aqui', style: TextStyle(fontFamily: 'sans', fontWeight: FontWeight.w600)),
                        onPressed: (){
                          //con este metodo vamos a ir pasando de ventana a ventana
                          //vamos a comenzar entonces
                          this.widget.cambiandoRegistro();
                        },
                      )
                    ],
                  )

                ],    
            )
        ),
      ),
    );
  }

void _submit() async {
  //cuando presione el boton vamos a hacer las siguientes validaciones

  //vamos a sacar los valores de nuestras cajas de texto 
  final String valorEmail = emailKey.currentState.valor;

  final String valorPassword = passwordKey.currentState.valor;


  final emailIsOk = emailKey.currentState.isOk;
  final passIsOk = passwordKey.currentState.isOk;

  if(emailIsOk && passIsOk){
    //si pasamos hasta aqui vamos a hacer la peticion
    final User usuario = await Auth.instance.signWithPassword(context, email: valorEmail, password: valorPassword);
    //entonces si ya tenemos un usuario entonces nos pasamos a nuestro home
    goTo(usuario);

  }else{
    ErroresDialogos.alert(context, title: 'Error', descripcion: 'ingrese solo datos validos');
  }
}

void goTo(User usuario){
  if(usuario != null){
    Navigator.pushReplacementNamed(context, 'home');
  }else{
    print('Algo salio mal al momento de autenticar');
  }
}

}

//primero que nada vamos a comenzar con las validaciones

//vamos a intentar hacer la conexion