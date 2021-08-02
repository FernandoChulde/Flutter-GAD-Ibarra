import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/models/post_campos/cabecera.dart';
import 'package:flutter_webview_predioibarra/services/services_post_campos/services_cabecera.dart';

class ViewPostCampos extends StatefulWidget {
  //ViewPostCampos({Key? key}) : super(key: key);
  final String claveSeleccionada;
  ViewPostCampos(this.claveSeleccionada);

  @override
  _ViewPostCamposState createState() => _ViewPostCamposState();
}

class _ViewPostCamposState extends State<ViewPostCampos> {
  
  String idCampo;

  Cabecera postCabecera;

  TextEditingController comentario;
  TextEditingController observaciones;
  
  @override
  void initState() { 
    super.initState();
    idCampo = widget.claveSeleccionada;
    comentario = new TextEditingController();
    observaciones = new TextEditingController();
    postCabecera = new Cabecera();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            //padding: EdgeInsets.all(32),
            child: Column(children: <Widget>[
              TextFormField(
                controller: comentario,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese comentario'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: observaciones,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese observaciones'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){
                  postCabecera.fii_id_ficha = idCampo;
                  postCabecera.fii_comentario = comentario.text;
                  postCabecera.fii_observaciones = observaciones.text;
                  postCabecera.fii_usuario = "TEST.APP";
                  ServicesCabecera serviceCabecera = new ServicesCabecera();
                  serviceCabecera.postCabecera(postCabecera).then((value){
                    setState(() {
                    });
                  });
                }, child: Text("Guardar"))
            ]
          )
    );
  }
}
