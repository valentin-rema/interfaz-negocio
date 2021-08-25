import 'package:app_locales/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Bienvenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Responsive responsiva = Responsive.of(context);

    return Stack(
      children: [
      //vamos a comenzar a colocar las imagenes que necesitamos
        AspectRatio(
          aspectRatio: 16/12,
          child: LayoutBuilder(
            builder: (_, constraints){
              return Container(
                //color: Colors.red,
                child: Stack(
                  children: [
                    //vamos a colocar un color de fondo
                    SvgPicture.asset('assets/nosotros.svg',
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                    Positioned(
                      top: constraints.maxHeight*.7,
                      child: Column(
                        children: [
                            Container(
                              width: constraints.maxWidth,
                              height: 3.0,
                              color: Color.fromRGBO(191,196,221, 1.0)
                            ),
                            //ahora vamos a colocar el texto
                            Text('Bienvenido', style: TextStyle(
                              fontSize: responsiva.inch*.045, 
                              fontFamily: 'raleway'
                            ))
                        ]
                      ),
                    ),
                    //ahora vamos a colocar la imagen
                    Positioned(
                      top: constraints.maxHeight*.4,
                      child: SvgPicture.asset('assets/valentin.svg',  
                        width: constraints.maxWidth*.4,
                        height: constraints.maxHeight*.3,
                        //height: 200.0,
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight*.29,
                      right: 0,
                      child: SvgPicture.asset('assets/yisita.svg',  
                        width: constraints.maxWidth*.45,
                        height: constraints.maxHeight*.6,
                        //height: 200.0,
                      ),
                    ),
                  ],
                ),
              );
            } 
          )
        ),
      ],
    );
  }
}
