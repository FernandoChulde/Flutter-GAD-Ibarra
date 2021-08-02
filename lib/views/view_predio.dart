import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/models/predio/predio.dart';
import 'package:flutter_webview_predioibarra/services/services_predio.dart';
import 'package:flutter_webview_predioibarra/views/view_inicio/drawer.dart';

class ViewPredio extends StatefulWidget {
  final String claveSeleccionada;
  ViewPredio(this.claveSeleccionada);

  @override
  _ViewPredioState createState() => _ViewPredioState();
}

class _ViewPredioState extends State<ViewPredio> {
  
  PredioServices pred = new PredioServices();
  Future<List<Predio>> listadoPredio;

  @override
  void initState() {
    super.initState();
    listadoPredio = pred.getPredio(widget.claveSeleccionada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predio"),
        backgroundColor: Colors.red,
      ),
      drawer: DrawerHome(),
      body: Container(
        color: Colors.blueGrey[50],
        child: Column(
          children: <Widget>[
            _clavePredio(),
            Expanded(child: _futurePredio()),
          ],
        ),
      ),
    );
  }

  Widget _clavePredio() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "Clave Predio: " + widget.claveSeleccionada,
        style: TextStyle(
            //color: Colors.blue,
            fontSize: 15.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _futurePredio() {
    return FutureBuilder(
      future: listadoPredio,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listPredio(snapshot.data),
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

  List<Widget> _listPredio(List<Predio> data) {
    List<Widget> predio = [];
    for (var pred in data) {
      predio.add(
        Container(
          child: Column(children: _tilePredio(pred)),
        ),
      );
    }
    return predio;
  }

  _tilePredio(Predio pred) {
    return ListTile.divideTiles(context: context, tiles: [
      ListTile(
        title: Text(
          "Información Propietario",
          //style: Theme.of(context).textTheme.headline1,
          style: TextStyle(
              color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Nombre propietario"),
          subtitle: Text(pred.nombre_propietario.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("RUC/Cedula propietario"),
          subtitle: Text(pred.ced_ruc_propietario),
        ),
      ),
      ListTile(
        title: Text(
          "Información Predio",
          style: TextStyle(
              color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Predio anterior"),
          subtitle: Text(pred.predialant.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Tipo predio"),
          subtitle: Text(pred.tipo_predio.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Propiedad"),
          subtitle: Text(pred.propiedad.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Calle"),
          subtitle: Text(pred.calle.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Calle secundaria"),
          subtitle: Text(pred.calle_s.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Nombre urbe"),
          subtitle: Text(pred.nombre_urb.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Numero vivienda"),
          subtitle: Text(pred.numero_vivienda.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Area solar"),
          subtitle: Text(pred.area_solar.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Area declarada"),
          subtitle: Text(pred.area_declarada_const.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Avaluo solar"),
          subtitle: Text(pred.avaluo_solar.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Avaluo construccion"),
          subtitle: Text(pred.avaluo_construccion.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Avaluo obra completa"),
          subtitle: Text(pred.avaluo_obra_complement.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Avaluo municipal"),
          subtitle: Text(pred.avaluo_municipal.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Numero lote"),
          subtitle: Text(pred.num_lote.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Numero manzana"),
          subtitle: Text(pred.num_manzana.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Ficha madre"),
          subtitle: Text(pred.ficha_madre.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Propiedad horizontal"),
          subtitle: Text(pred.propiedad_horizontal.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Alicuota terreno"),
          subtitle: Text(pred.alicuota_terreno.toString()),
        ),
      ),
    ]).toList();
  }
}
