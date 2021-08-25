
//vamos a construirlos

import 'package:app_locales/utils/colores.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class BotonAcceder extends StatelessWidget {

  //vamos a poner las variables dinamicas
  final Color color;
  final VoidCallback onPress;
  final String label;

  const BotonAcceder({
    this.color, 
    @required this.onPress, 
    @required this.label
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      //color: Colors.red,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(label, style: TextStyle(fontFamily: 'sans', color: Colors.white, fontSize: 15)),
        decoration: BoxDecoration(
          color: this.color?? Colores.colorPrimario,
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onPressed: this.onPress
    );
  }
}