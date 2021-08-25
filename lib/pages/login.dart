//vamos a comenzar por pintar las lineas de nuestro encabezado
import 'package:app_locales/pages/olvide_password.dart';
import 'package:app_locales/pages/registro.dart';
import 'package:app_locales/utils/responsive.dart';
import 'package:app_locales/widgets/login/bienvenido.dart';
import 'package:app_locales/widgets/login/form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';



//vamos a definir la clase para el controlador del estado del pageController
class ManejoPaginas{
  //puras variables estaticas
  static int pagina1 = 0;
  static int pagina2 = 1;
  static int pagina3 = 2;

}
//metodo para que vayamos cambiando de pagina

//vamos a comenzar a pintar las lineas de arriba
class Encabezado extends StatefulWidget {
  //vamos a contruir el key de nuestro form
  @override
  _EncabezadoState createState() => _EncabezadoState();
}

class _EncabezadoState extends State<Encabezado> with AfterLayoutMixin{

  void switchPagina(int numero){
    //vamos a comenzar 
    this._cPagina.animateToPage(numero, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);  
  }

  PageController _cPagina = new PageController(initialPage: 0);


  @override
  void afterFirstLayout(BuildContext context) async {
    //aqui vamos a colocar el codigo que vamos a ejecutar una vez que se acabe de 
    //pintar el diseño de todo nuestro widget
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await Firebase.initializeApp();

  }

  //vamos a comenzar con la definicion de las variables globales
  @override
  Widget build(BuildContext context) {

    final Responsive responsiva = Responsive.of(context);

    //ok vamos a continuar, vamos a hacer que neuestra aplicacion corra unicamente con portrait 
    //asi que vamos a comenzar 
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              height: responsiva.alto,
              width: responsiva.ancho,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bienvenido(), //==>widget para el encabezado
                  //una parte del body ya quedo para la parte de bienvenido entonces lo que sobra
                  //lo hacemos en un pageView
                  Expanded(
                      child: PageView(
                        controller: _cPagina,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          FormAcceso(cambiandoRegistro: (){
                            switchPagina(ManejoPaginas.pagina2);
                          },
                          forgotPassword: (){
                            switchPagina(ManejoPaginas.pagina3);
                          }
                          ),
                          FormRegistro(cambiandoPagina: (){
                            switchPagina(ManejoPaginas.pagina1);
                          },),
                          ForgotPassword(cambiandoPagina: (){
                            switchPagina(ManejoPaginas.pagina1);
                          },)                 
                        ],
                      ),
                    ),
                ]
              ),
            ),
          ),
          ),
      ),
    );
  }
}

//vamos a continuar con el curso, manos a la obra



