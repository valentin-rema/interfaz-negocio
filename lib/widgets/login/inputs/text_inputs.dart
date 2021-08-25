import 'package:app_locales/utils/colores.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';


class InputText extends StatefulWidget {

  final String textoD;
  final String pathImagen;
  final String initValue; //==> estaremos mandando el texto
  //vamos a necesitar una funcion
  final bool Function(String text) validator;
  
  final bool esconder;

  const InputText({
    Key key,
    @required this.textoD, 
    @required this.pathImagen,
    this.validator,
    this.initValue = '', 
    this.esconder = false
  }) : super(key: key);

  @override
  InputTextState createState() => InputTextState();
}

class InputTextState extends State<InputText> {

  TextEditingController _controller;
  //vamos a coloca lo que necesitemos
  bool _validationOk = false;


  //vamos a sacar lo que tiene controller de forma publica
  String get valor => this._controller.text;

  bool get isOk => this._validationOk;


  void checkValidation(){
    if(widget.validator != null){
      //vamos con la siguiente condicional
      final bool isOk = widget.validator(_controller.text);
      if(_validationOk != isOk){
        setState(() {
          _validationOk = isOk;          
        });
      }
    }
  }

  @override
  void initState() { 
    super.initState();
    //codigo antes de que se pinte el widget
    _controller = TextEditingController(text: widget.initValue);
    //vamos a comenzar con la funcion de checkValidation
    checkValidation();
  }

  @override
  void dispose() { 
    super.dispose();
    _controller?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      obscureText: widget.esconder,
      style: TextStyle(fontFamily: 'sans'),
      controller: _controller,
      padding: EdgeInsets.all(10.0),
      //cada que vamos cambiando igual
      onChanged: (text){
        //vamos a mandar a llamar la funcion de verificar
        checkValidation();
      },
      prefix: Container(
        padding: EdgeInsets.all(2.0),
        width: 40.0,
        height: 30.0,
        child: SvgPicture.asset(
          widget.pathImagen,
          color: Color(0xffcccccc))
      ),
      suffix: _validationOk ? Icon(Icons.check_circle, color: Colores.colorPrimario) : Icon(Icons.check_circle, color: Colors.grey),
      placeholder: widget.textoD,
      placeholderStyle: TextStyle(fontFamily: 'sans', color: Color(0xffcccccc)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffdddddd),
            width: 2.0
          )
        )
      )
    );
  }
}

//ahora que ya tenemos todo la parte de la validacion vamos a intentar ingresar
