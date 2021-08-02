import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webview_predioibarra/models/zonificacion/zonificacion.dart';

class ZonificacionServices{

  //GET Zonificación 
  Future<List<Zonificacion>> getZonificacion(clave) async {
    final response = await http.get("https://desarrollosigm.ibarra.gob.ec/apimv/rest/getZonificacionByPredio.php?cc="+clave);
    // print("Si entra");
    // print(response.statusCode);
    List<Zonificacion> zonificacion = [];

    if (response.statusCode == 200) {
      // Evitar error de sintaxis en la vista con palabras con tiles, ñ, etc...
      String body = utf8.decode(response.bodyBytes);
      // Convertir a json
      final jsonData = jsonDecode(body);
      // print(jsonData);
      // print(jsonData[0]["codificacion"]);
      // Recorre data y añade los datos en la lista
      for (var item in jsonData["zonificaciones"]) {
        zonificacion.add(Zonificacion(
          item["codificacion"],
          item["forma_ocupacion"],
          item["lote_minimo"],
          item["frente_minimo"],
          item["frontal"],
          item["lateral"],
          item["posterior"],
          item["cos"],
          item["cos_t"],
          item["dist_bloq"],
          item["altura_edi"],
          item["uso_principal"],
          item["zonificacion"],
          item["pt_12_zonificacion"]
          )
        );
      }
      //print(jsonData);
      //print(predio);
      return zonificacion;
    } else {
      throw Exception("Fallo la conexión");
    }
  }

}