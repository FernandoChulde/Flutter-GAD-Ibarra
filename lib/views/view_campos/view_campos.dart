import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/models/campos_ficha/campos_ficha.dart';
import 'package:flutter_webview_predioibarra/models/opciones_campos/opciones_campos.dart';
import 'package:flutter_webview_predioibarra/models/post_campos/detalle.dart';
import 'package:flutter_webview_predioibarra/services/services_campos_ficha/services_campos.dart';
import 'package:flutter_webview_predioibarra/services/services_opciones_campos/services_opcion.dart';
import 'package:flutter_webview_predioibarra/services/services_post_campos/services_detalle.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_cabecera.dart';
import 'package:flutter_webview_predioibarra/views/view_inicio/drawer.dart';
import 'package:flutter_webview_predioibarra/views/view_post_campos/view_post_campos.dart';

class ViewCampos extends StatefulWidget {
  final String claveSeleccionada;
  ViewCampos(this.claveSeleccionada);

  @override
  _ViewCamposState createState() => _ViewCamposState();
}

class _ViewCamposState extends State<ViewCampos> {
  String idCampo;
  CamposServices inspeccionServices = new CamposServices();
  Future<List<CamposFicha>> listadoCamposFichas;
  String _tipoOpcion1;
  String _tipoOpcion2;
  String _tipoOpcion3;
  String _tipoOpcion4;
  String _tipoOpcion5;
  String _tipoOpcion6;
  String _tipoOpcion7;
  String _tipoOpcion8;
  String _tipoOpcion9;
  String _tipoOpcion10;

  OpcionServices opcionServices = new OpcionServices();
  Future<List<OpcionesCampos>> listadoOpcionesCampos;

  TextEditingController controllCampos;
  Detalle detalle;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idCampo = widget.claveSeleccionada;
    listadoCamposFichas = inspeccionServices.getCamposFicha(idCampo);
    detalle = new Detalle();
    controllCampos = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Campos"), backgroundColor: Colors.red),
      drawer: DrawerHome(),
      body: Container(
        color: Colors.blueGrey[50],
        child: Column(
          children: <Widget>[
            Expanded(child: _futureSeleccionCampo(this.idCampo)),
            ViewPostCampos(this.idCampo),
            
          ],
        ),
      ),
    );
  }

  Widget _futureSeleccionCampo(id) {
    return FutureBuilder(
      future: listadoCamposFichas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listCamposFicha(snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<Widget> _listCamposFicha(List<CamposFicha> data) {
    List<Widget> camposFicha = [];
    for (var ins in data) {
      camposFicha.add(
        Container(
          child: Column(children: _tileCampos(ins)),
        ),
      );
    }
    return camposFicha;
  }

  _tileCampos(CamposFicha campos) {
    return ListTile.divideTiles(context: context, tiles: [
      Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(campos.fic_nombre.toString()),
              subtitle: Text(campos.fic_descripcion.toString()),
              // onTap: (){
              //   Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => ViewCampos(ficha.fit_id),
              // ));
              // },
            ),
            Container(
              child: _getTextTipoOpcion(
                  campos.fic_tipo_opcion, campos.fic_descripcion),
            ),
            ElevatedButton(
              onPressed: (){
                ServicesDetalle servicesDetalle = new ServicesDetalle();
                detalle.id_ficha_info = PreferencesCabecera.getFiiId();
                detalle.id_campo = campos.fic_tipo;
                detalle.valor = controllCampos.text;
                setState(() {
                  servicesDetalle.postDetalle(detalle);
                  controllCampos.clear();
                });
              }, child: Text("Agregar"))
          ],
        ),
      )
    ]).toList();
  }

  _getTextTipoOpcion(id, descripcion) {
    if (id != "0") {
      return FutureBuilder<List<OpcionesCampos>>(
          future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButton(
                //value: _tipoOpcion1,
                value: (id=="1") ? _tipoOpcion1: (id=="2") ? _tipoOpcion2 : (id=="3") ? _tipoOpcion3: (id=="4") ? _tipoOpcion4 :
                (id=="5") ? _tipoOpcion5: (id=="6") ? _tipoOpcion6 : (id=="7") ? _tipoOpcion7: (id=="8") ? _tipoOpcion8 :
                (id=="9") ? _tipoOpcion9: _tipoOpcion10,
                style: TextStyle(color: Colors.black),
                items: snapshot.data.map((OpcionesCampos value) {
                  return DropdownMenuItem(
                    value: value.foc_nombre,
                    child: Text(value.foc_nombre),
                  );
                }).toList(),
                hint: Text(
                  "Escoger una Opción",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (String value) {
                  setState(() {
                    if (id == "1") {
                      _tipoOpcion1 = value;
                      //print("$_tipoOpcion1"+_tipoOpcion1);
                    } else if (id == "2"){
                      _tipoOpcion2 = value;
                      //print("$_tipoOpcion2"+_tipoOpcion2);
                    } else if (id == "3"){
                      _tipoOpcion3 = value;
                      //print("$_tipoOpcion3"+_tipoOpcion3);
                    } else if (id == "4"){
                      _tipoOpcion4 = value;
                      //print("$_tipoOpcion4"+_tipoOpcion4);
                    } else if (id == "5"){
                      _tipoOpcion5 = value;
                      //print("$_tipoOpcion5"+_tipoOpcion5);
                    } else if (id == "6"){
                      _tipoOpcion6 = value;
                      //print("$_tipoOpcion6"+_tipoOpcion6);
                    } else if (id == "7"){
                      _tipoOpcion7 = value;
                      //print("$_tipoOpcion7"+_tipoOpcion7);
                    } else if (id == "8"){
                      _tipoOpcion8 = value;
                      //print("$_tipoOpcion8"+_tipoOpcion8);
                    } else if (id == "9"){
                      _tipoOpcion9 = value;
                      //print("$_tipoOpcion9"+_tipoOpcion9);
                    } else {
                      _tipoOpcion10 = value;
                      //print("$_tipoOpcion10"+_tipoOpcion10);
                    }
                    //_tipoOpcion1 = value;
                    //print("llega"+_tipoOpcion);
                  });
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    // } else if (id == "2") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion2,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion2 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "3") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion3,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion3 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "4") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion4,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion4 = value;
    //                 //print("llega"+_tipoOpcion4);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "5") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion5,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion5 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "6") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion6,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion6 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "7") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion7,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion7 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "8") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion8,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion8 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "9") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion9,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion9 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // } else if (id == "10") {
    //   return FutureBuilder<List<OpcionesCampos>>(
    //       future: listadoOpcionesCampos = opcionServices.getOpcionesCampos(id),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           return DropdownButton(
    //             value: _tipoOpcion10,
    //             style: TextStyle(color: Colors.black),
    //             items: snapshot.data.map((OpcionesCampos value) {
    //               return DropdownMenuItem(
    //                 value: value.foc_nombre,
    //                 child: Text(value.foc_nombre),
    //               );
    //             }).toList(),
    //             hint: Text(
    //               "Escoger una Opción",
    //               style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w600),
    //             ),
    //             onChanged: (String value) {
    //               setState(() {
    //                 _tipoOpcion10 = value;
    //                 //print("llega"+_tipoOpcion);
    //               });
    //             },
    //           );
    //         } else if (snapshot.hasError) {
    //           return Text("Error");
    //         }
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    } else {
      //return ViewPostCampos();
      return TextFormField(
        controller: controllCampos,
        decoration: InputDecoration(
          labelText: "INGRESAR " + descripcion,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
          ),
        ),
      );
    }
  }
}
