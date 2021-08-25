import 'package:app_locales/utils/responsive.dart';
import 'package:app_locales/widgets/login/botones/boton-login.dart';
import 'package:app_locales/widgets/login/inputs/text_inputs.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class ForgotPassword extends StatefulWidget {

  final VoidCallback cambiandoPagina;

  const ForgotPassword({
    @required this.cambiandoPagina
  });

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Text('Restaurar Contraseña', style: TextStyle(fontFamily: 'raleway', fontSize: responsiva.phi(4.5), color: Theme.of(context).primaryColor)),
                  Text('ingrese su correo electronico para que el equipo de desarrollo le mande via correo electronico una serie de instrucciones para poder recuperar su contraseña',
                    style: TextStyle(fontFamily: 'sans', color: Colors.black45, fontSize: responsiva.phi(2)), textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: responsiva.phi(5)),
                  InputText(textoD: 'Correo Electronico', pathImagen: 'assets/email.svg',),
                  //SizedBox(height: responsiva.phi(2.5))
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
                      Expanded(
                        child: Container()
                      ),
                      BotonAcceder(
                      onPress: (){
                        //ahorita volvemos
                      }, 
                      label: 'Enviar'
                    ),
                    ],
                  ),
                  //SizedBox(height: responsiva.phi(2)),
                  //ahora vamos a colocar un texto
                  //SizedBox(height: responsiva.phi(3))
                ],    
            )
        ),
      ),
    );
  }
}