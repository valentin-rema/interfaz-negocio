import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart' show required;

import 'dart:math' as math;

class Responsive{
    final double ancho, alto, inch;

  Responsive({
  @required this.ancho, 
  @required this.alto, 
  @required this.inch
  });

  //ahora vamos a hacer la parte de el metod estatico

  factory Responsive.of(BuildContext context){
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    //vamos a calcular la medida de la diagonal 
    final hipo = math.sqrt(math.pow(size.width, 2)+math.pow(size.height, 2));

    return Responsive(
      ancho: size.width,
      alto: size.height,
      inch: hipo
    );
  }

  //vamos con los metodos para calcular los porcentajes
  double pan(double porcentaje){
    return this.ancho * porcentaje / 100;
  }

  double pal(double porcentaje){
    return this.alto * porcentaje / 100;
  }

  double phi(double porcentaje){
    return this.inch * porcentaje / 100;
  }

}

