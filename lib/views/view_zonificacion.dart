import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/models/zonificacion/zonificacion.dart';
import 'package:flutter_webview_predioibarra/services/services_zonificacion.dart';
import 'package:flutter_webview_predioibarra/views/view_inicio/drawer.dart';

class ViewZonificacion extends StatefulWidget {
  final String claveSeleccionada;
  ViewZonificacion(this.claveSeleccionada);

  @override
  _ViewZonificacionState createState() => _ViewZonificacionState();
}

class _ViewZonificacionState extends State<ViewZonificacion> {
  ZonificacionServices zon = new ZonificacionServices();
  Future<List<Zonificacion>> listadoZonificacion;

  @override
  void initState() {
    super.initState();
    listadoZonificacion = zon.getZonificacion(widget.claveSeleccionada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zonificación"),
        backgroundColor: Colors.red,
      ),
      drawer: DrawerHome(),
      body: Container(
        color: Colors.blueGrey[50],
        child: Column(
          children: <Widget>[
            _clavePredio(),
            Expanded(child: _futureZonificacion()),
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
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _futureZonificacion() {
    return FutureBuilder(
      future: listadoZonificacion,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listZonificacion(snapshot.data),
          );
          //print(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("Error");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<Widget> _listZonificacion(List<Zonificacion> data) {
    List<Widget> zonificacion = [];
    for (var zon in data) {
      zonificacion.add(Container(
        child: Column(
          children: _tileZonificacion(zon),
        ),
      ));
    }
    return zonificacion;
  }

  _tileZonificacion(Zonificacion zon) {
    return ListTile.divideTiles(context: context, tiles: [
      ListTile(
        title: Text(
          "Información Zonificación",
          style: TextStyle(
              color: Colors.blueGrey, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("Codificación"),
          subtitle: Text(zon.codificacion.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("forma_ocupacion"),
          subtitle: Text(zon.forma_ocupacion.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("lote_minimo"),
          subtitle: Text(zon.lote_minimo.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("frente_minimo"),
          subtitle: Text(zon.frente_minimo.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("frontal"),
          subtitle: Text(zon.frontal.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("lateral"),
          subtitle: Text(zon.lateral.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("posterior"),
          subtitle: Text(zon.posterior.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("cos"),
          subtitle: Text(zon.cos.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("cos_t"),
          subtitle: Text(zon.cos_t.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("dist_bloq"),
          subtitle: Text(zon.dist_bloq.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("altura_edi"),
          subtitle: Text(zon.altura_edi.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("uso_principal"),
          subtitle: Text(zon.uso_principal.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("zonificacion"),
          subtitle: Text(zon.zonificacion.toString()),
        ),
      ),
      Card(
        child: ListTile(
          title: Text("pt_12_zonificacion"),
          subtitle: Text(zon.pt_12_zonificacion.toString()),
        ),
      ),
    ]).toList();
  }
}
