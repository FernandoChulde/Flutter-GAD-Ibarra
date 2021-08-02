import 'package:flutter_webview_predioibarra/models/opciones_campos/opciones_campos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class OpcionServices{

  //GET Predio
  Future<List<OpcionesCampos>> getOpcionesCampos(id) async {
    final response = await http.get("https://desarrollosigm.ibarra.gob.ec/apimv/rest/getOpcionesByTipoCampo.php?cc="+id);
    //print("Si entra");
    List<OpcionesCampos> opciones = [];

    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      // Convertir a json
      final jsonData = jsonDecode(body);

      for (var item in jsonData) {
        opciones.add(OpcionesCampos(
          item["foc_id"],
          item["foc_nombre"],
          item["foc_descripcion"]
        ));
      }
      print(jsonData); 
      return opciones;
    } else {
      throw Exception("Fallo la conexión");
    }
  }

}