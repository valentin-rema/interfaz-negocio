
//vamos con la construccion del pie de pagina
import 'package:flutter/material.dart';

class PiePagina extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    
      //vamos a comenzar con la pintada
      
      final lapiz = new Paint();

      //vamos a comenzar 
      lapiz.color = Colors.white;

      lapiz.style = PaintingStyle.fill;

      lapiz.strokeWidth = 0.0;

      //ahora si vamos a comenzar con el dibujo
      final path = new Path();

      path.lineTo(0, size.height);

      path.quadraticBezierTo(size.width*.95, size.height*.50, size.width, 0);

      path.lineTo(0,0);

      canvas.drawPath(path, lapiz);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}