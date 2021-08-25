
import 'package:flutter/material.dart';

class CustomEncabezado extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    //vamos a comenzar pintar entonces 
    final lapiz = new Paint();

    //ahora vamos a comenzar a dibujar una lineas
    lapiz.color = Color.fromRGBO(41,162,209, 0.9);
    
    lapiz.style = PaintingStyle.fill;

    lapiz.strokeWidth = 10;

    final path = new Path();

    path.lineTo(0, size.height*.35);
    //ahora desde ese punto vamos a pintar una curva
    path.quadraticBezierTo(size.width*.12, size.height*.20, size.width*.40, size.height*.15);


    //vamos a pintar otro arco entonces
    path.quadraticBezierTo(size.width*.70, size.height*.16, size.width, 0);

    //ahora vamos a cerrar el encabezado

    //path.lineTo(0,0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}