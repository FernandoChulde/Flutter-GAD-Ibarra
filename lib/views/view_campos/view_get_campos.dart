import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/views/view_post_campos/view_post_campos.dart';
import 'package:flutter_webview_predioibarra/views/view_tipoFicha.dart';

class ViewGetCampos extends StatefulWidget {
  //ViewGetCampos({Key? key}) : super(key: key);

  @override
  _ViewGetCamposState createState() => _ViewGetCamposState();
}

class _ViewGetCamposState extends State<ViewGetCampos> {
  String idCampo;
  String _value = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get campos"), actions: [
        PopupMenuButton(
            enabled: true,
            onSelected: (value) {
              setState(() {
                _value = value;
                if (_value == "2") {
                  Navigator.of(context).push(MaterialPageRoute(
                    //builder: (context) => ViewCampos(ficha.fit_id),
                    builder: (context) => ViewTipoFicha(),
                  ));
                }
              });
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Editar"),
                    value: "1",
                  ),
                  PopupMenuItem(
                    child: Text("Observaciones"),
                    value: "2",
                  )
                ])
      ]),
    );
  }
}
