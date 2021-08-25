//vamos a construir el dialog
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//vamos a crear una clase donde manejemos lo siguiente
class ErroresDialogos{
  //vamos a usar una funcion static
  static void alert(BuildContext context, {
    String title, String descripcion
  }){
    //vamos a comenzar
    showDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: (title != null) ? Text(title) : null,
        content: (descripcion != null) ? Text(descripcion) : null,
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}

class Dialogo{

  //vamos a recibir el context 
  final BuildContext context;

  Dialogo(this.context);

  //vamos a construir el metodo
  show(){
      //vamos a mostrar el chido pues 
      showCupertinoModalPopup(context: this.context, builder: ( _ ) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white.withOpacity(0.6),
          child: Center(
            child: CupertinoActivityIndicator(radius: 25.0)
          )
        );
      });
  }
  //metodo para borrar el showDialog
  dismiss(){
    Navigator.pop(this.context);
  }
}