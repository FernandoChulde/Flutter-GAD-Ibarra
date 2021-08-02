import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/models/tipo_ficha/tipo_ficha.dart';
import 'package:flutter_webview_predioibarra/services/services_tipoFicha.dart';
import 'package:flutter_webview_predioibarra/views/view_campos/view_campos.dart';
import 'package:flutter_webview_predioibarra/views/view_inicio/drawer.dart';
import 'package:flutter_webview_predioibarra/views/view_post_campos/view_post_campos.dart';

class ViewTipoFicha extends StatefulWidget {
  @override
  _ViewTipoFichaState createState() => _ViewTipoFichaState();
}

class _ViewTipoFichaState extends State<ViewTipoFicha> {
  TipoFichaServices fichaServices = new TipoFichaServices();
  Future<List<TipoFicha>> listaFicha;

  @override
  void initState() {
    super.initState();
    listaFicha = fichaServices.getTipoFicha();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fichas"),
        backgroundColor: Colors.red,
      ),
      drawer: DrawerHome(),
      body: Container(
        color: Colors.blueGrey[50],
        child: Column(
          children: <Widget>[
           Expanded(child: _futureFicha()),
          ],
        ),
      ),
    );
  }

   Widget _futureFicha() {
    return FutureBuilder(
      future: listaFicha,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listFicha(snapshot.data),
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

  List<Widget> _listFicha(List<TipoFicha> data) {
    List<Widget> ficha = [];
    for (var tipoF in data) {
      ficha.add(
        Container(
          child: Column(children: _tileFicha(tipoF)),
        ),
      );
    }
    return ficha;
  }

  _tileFicha(TipoFicha ficha) {
    return ListTile.divideTiles(context: context, tiles: [
      Card(
        child: ListTile(
          title: Text(ficha.fit_nombre.toString()),
          subtitle: Text(ficha.fit_departamento.toString()),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewCampos(ficha.fit_id),
            //builder: (context) => ViewPostCampos(ficha.fit_id),
          ));
          },
        ),
        
      )
    ]).toList();
  }

}
