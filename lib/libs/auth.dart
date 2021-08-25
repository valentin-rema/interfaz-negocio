//vamos a comenzar con la construccion de mi clase singleton
import 'package:app_locales/dialogs/pintar_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Auth{

  Auth._internal();

  static Auth get instance => Auth._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  
  //metodo GET
  User get datosUsuario {
      return _auth.currentUser;
  }

  //ahora vamos con el metodo para poder logearme con facebook
  Future<User> facebook(BuildContext context) async {
    try{

      //vamos a comenzar con la parte de facebook
      final Dialogo ventana = new Dialogo(context);

      //vamos a colocar la ventana
      ventana.show();

      final LoginResult resultado = await FacebookAuth.instance.login();

      //resultado.status devuelve tres numeros enteros los cuales son los siguientes
      //200, 403, 500
      //200 la conexion es exitosa
      //403 cancelo la conexion
      //500 hubo un error de autenticacion
      if(resultado.status == 200){
          //=====>>>>obtenemos los datos del usuario
          //final datosUsuario = await FacebookAuth.instance.getUserData();
          //print(datosUsuario);

          //vamos a continuar ahora con la obtencion de los datos de usuario mediante el firebaseUser

          final OAuthCredential credencial = FacebookAuthProvider.credential(resultado.accessToken.token);

          final UserCredential result = await _auth.signInWithCredential(credencial);


          final User usuario = result.user;

          //vamos a retornar el usuario entonces
          ventana.dismiss();
          return usuario;

      }else if(resultado.status == 403){
        print('====>>>>>El usuario no se quizo conectar');
        return null;
      }else{
        //error de autenticacion
        print('====>>>>>Error con el servicio de facebook');
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }
  }
  //vamos a colocar los metodos
  Future<User> google(BuildContext context) async {
    try{

      final Dialogo ventana = new Dialogo(context);
      ventana.show();

      final GoogleSignInAccount cuenta = await _googleSignIn.signIn();
      final GoogleSignInAuthentication autenticacion = await cuenta.authentication; 

      final AuthCredential credencial = GoogleAuthProvider.credential(
        idToken: autenticacion.idToken,
        accessToken: autenticacion.accessToken
      );

      final UserCredential result =  await _auth.signInWithCredential(credencial);

      final User usuario =  result.user;
      //vamos a retornar el usuario
      ventana.dismiss();
      return usuario;
    }catch(e){
      print('===>>>cancelamos la peticion de conexion con google');
      return null;
    }
  } 

  //vamos con la parte de la autenticacion 
  Future<User> signUp(BuildContext context, {
    @required String username, 
    @required String correo,
    @required contrasena
  }) async {
    Dialogo ventana = new Dialogo(context);
    try{
      ventana.show();

      final UserCredential resultCredential = await _auth.createUserWithEmailAndPassword(
        email: correo,
        password: contrasena
      );

      //vamos a ver si encontramos algo
      if(resultCredential.user != null){ 
        await resultCredential.user.updateProfile(displayName: username);
        ventana.dismiss();
        return resultCredential.user;
      }else{
        ventana.dismiss();
        return null;
      }
    }on FirebaseAuthException catch(e){
      ventana.dismiss();
      if( e.code == 'email-already-in-use'){
        //vamos a mandar una alerta de dialogo
        ErroresDialogos.alert(context, title: 'Error', descripcion: 'El email ya esta siendo usado por otro Usuario');
      }
      return null;
    }
  } 

  //metodo para restaurar la contraseña mediante email
  Future<bool> resetPassword(BuildContext context, {
    @required String email
  }) async {
    Dialogo ventana = new Dialogo(context);
    try{
      //ahora vamos a comenzar con el reseteo de la contraseña
      ventana.show();
      await _auth.sendPasswordResetEmail(email: email);
      ventana.dismiss();
      return true;
    }catch(e){
      print(e);
      ventana.dismiss();
      return false;
    }
  }

  //metodo para la autenticacion mediante correo y contraseña
  Future<User> signWithPassword(BuildContext context, {
    String email,
    String password
  }) async {
    //ahora si vamos a comenzar
    final cargando = new Dialogo(context);
    try{
      cargando.show();
      //ahora vamos a comenzar con los metodos
      final UserCredential credenciales = await _auth.signInWithEmailAndPassword(email: email, password: password);

      if( credenciales.user != null ){
        cargando.dismiss();
        return credenciales.user;
      }else{
        cargando.dismiss();
        return null;
      }
    }catch(e){
      cargando.dismiss();
      print(e);
      return null;
    }

  }



  //==>>Metodo cerrar sesion
  void logOut(BuildContext context) async {
      //primero vamos a ver con que red social nos conectamos
      final String tipoConexion = datosUsuario.providerData[0].providerId;
      //ahora vamos a ver con que nos conectamos
      
      switch(tipoConexion){
        case 'facebook.com':
          //vamos a desconectarnos
          await FacebookAuth.instance.logOut();
          print('Nos desconectamos de facebook');
        break;
        case 'google.com':
          await _googleSignIn.signOut();
          print('nos desconectamos de google');
        break;
        case 'cuenta':

        break;
        case 'password':

        break;
      }

      //vamos a eliminar la conexion de User
      await _auth.signOut();

      //ahora que nos desconectamos vamos a pasarnos a la parte del login
      Navigator.pushNamedAndRemoveUntil(context, 'login', ( _ ) => false);
  }
}

//vamos con la parte del manejo de la validacion de la misma contraseña


