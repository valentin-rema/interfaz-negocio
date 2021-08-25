import 'package:app_locales/dialogs/pintar_dialog.dart';
import 'package:app_locales/libs/auth.dart';
import 'package:app_locales/utils/responsive.dart';
import 'package:app_locales/widgets/login/botones/boton-login.dart';
import 'package:app_locales/widgets/login/inputs/text_inputs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class FormRegistro extends StatefulWidget {

  final VoidCallback cambiandoPagina;

  const FormRegistro({
    @required this.cambiandoPagina
  });

  @override
  _FormRegistroState createState() => _FormRegistroState();
}

class _FormRegistroState extends State<FormRegistro> {

  //ahora vamos a definir unos globalkey asi que manos a la obra

  final GlobalKey<InputTextState> userNameKey = GlobalKey();
  final GlobalKey<InputTextState> userMailKey = GlobalKey();
  final GlobalKey<InputTextState> userPasswordKey = GlobalKey();
  final GlobalKey<InputTextState> userVPasswordKey = GlobalKey();

  

  bool valorCaja = false;

  @override
  Widget build(BuildContext context) {

    final Responsive responsiva = Responsive.of(context);
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        bottom: false,
        child: Container(
            width: responsiva.pan(95),
            //color: Colors.red,
            //height: 200.0,
            //vamos a colocar la parte del form
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  //coloquemos un texto
                  Text('Nueva Cuenta', style: TextStyle(fontFamily: 'raleway', fontSize: 30.0, color: Theme.of(context).primaryColor)),
                  //vamos a colocar a los inputs text de forma dinamica
                  InputText(
                    key: userNameKey,
                    textoD: 'User Name', 
                    pathImagen: 'assets/user.svg', 
                    validator: (texto){
                      return texto.trim().length > 0; 
                    },
                  ),
                  //SizedBox(height: responsiva.phi(2.5)),
                  InputText(
                    key: userMailKey,
                    textoD: 'Correo Electronico', 
                    pathImagen: 'assets/email.svg',
                    validator: (texto){
                      return texto.contains('@');
                    },
                  ),
                  //SizedBox(height: responsiva.phi(2.5)),
                  InputText(
                    key: userPasswordKey,
                    textoD: 'Contraseña', 
                    pathImagen: 'assets/pass.svg',
                    validator: (texto){
                      //ahora vamos a mandar la confirmacion en nuestra caja de validar contraseña
                      //vamos a vemos como funcionas
                      
                      //vamos a manejar el validator de la confirmacion del password desde aqui
                      userVPasswordKey.currentState?.checkValidation();

                      return texto.trim().length >= 6;
                      
                    },
                    esconder: true,
                  ),
                  //ahora vamos a crear el boton para acceder
                  //SizedBox(height: responsiva.phi(2.5)),
                  InputText(
                    key: userVPasswordKey,
                    textoD: 'Confirma la contraseña', 
                    pathImagen: 'assets/pass.svg',
                    validator: (texto){
                      return ((texto == userPasswordKey.currentState.valor) && texto.trim().length >= 6);
                    },
                    esconder: true,
                  ),
                  Row(
                      children: [
                        //vamos a colocar la caja de verificacion
                        Checkbox(
                          value: this.valorCaja,
                          onChanged: (valor){
                            setState(() {
                              this.valorCaja = valor;                              
                            });
                          },
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'sans',
                            fontSize: responsiva.phi(1.5),  
                          ),
                          child: Row(
                            children: [
                              Text('al utilizar la app visualize'),
                              InkWell(
                                child: Text('Terminos y condiciones', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                                onTap: (){
                                  print('terminos y condiciones');
                                },
                              )
                            ],
                          ),
                        )
                      ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //vamos a colocar un flatbutton
                      FlatButton(
                        child: Text('← Volver al login', style: TextStyle(fontFamily: 'sans', fontSize: 16.0, color: Theme.of(context).primaryColor)),
                        onPressed: (){
                          widget.cambiandoPagina();
                        },
                      ),
                      BotonAcceder(
                      onPress: (){
                        //cuando presionemos el boton de registro vamos a sacar los datos
                        _submit();
                      }, 
                      label: 'Registrarme'
                    ),
                    ],
                  ),
                  //SizedBox(height: responsiva.phi(2)),
                  //ahora vamos a colocar un texto
                ],    
            )
        ),
      ),
    );
  }

  _goTo(User usuario){
    //vamos a ver si obtenemos el usuario
    if(usuario != null){
      //quire decir que se hizo bien 
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      print('====>>>>Ops error al momento de la autenticacion');
    }
  }


  _submit() async {
    //vamos a comenzar 
    String userName = userNameKey.currentState.valor;
    String userEmail = userMailKey.currentState.valor;
    String userPassword = userPasswordKey.currentState.valor;
    

    //una vez que ya obtuvimos los campos vamos a ver si estan bien
    final bool nameOk = userNameKey.currentState.isOk;
    final bool mailOk = userMailKey.currentState.isOk;
    final bool passOk = userPasswordKey.currentState.isOk;
    final bool vpassOk = userVPasswordKey.currentState.isOk;

    //vamos a ver si todas las validaciones son correctas
      if( nameOk && mailOk && passOk && vpassOk ){
      //ademas tengo que aceptar los terminos y condiciones
      if(this.valorCaja){
        //si es que si aceptamos los terminos y condiciones entonces
        final User usuario = await Auth.instance.signUp(context,
          username: userName,
          correo: userEmail,
          contrasena: userPassword         
        );        

        //ahora ese usuario lo vamos a obtener
        _goTo(usuario);

      }else{
        ErroresDialogos.alert(context,
          title: 'Error',
          descripcion: 'Tiene que aceptar los terminos y condiciones'
        );
      } 
      }else{
      //vamos a mandar un mensaje de alerta
      ErroresDialogos.alert(context, title: 'Error', descripcion: 'Algunos datos no estan completos');
    }
  }
}
//bien ahora vamos con la parte de crear una cuenta con los datos que vamos a llenar

