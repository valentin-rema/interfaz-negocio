
//vamos a comenzar 
import 'package:app_locales/utils/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BotonesRedes extends StatelessWidget {

  final double size;
  final Color background;
  final String path;

  //vamos a agregar el metodo onPress()
  final VoidCallback onPress;

  const BotonesRedes({
    this.size = 50, 
    this.background,
    @required this.path,
    @required this.onPress
  });
  
  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
      child: Container(
        width: this.size,
        height: this.size,
        decoration: BoxDecoration(
          color: this.background?? Colores.colorPrimario,
          shape: BoxShape.circle
        ),
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(
          path,
          color: Colors.white,
        )
      ),
      onPressed: this.onPress,
    );
  }
}