import 'package:flutter_webview_predioibarra/models/campos_ficha/campos_ficha.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CamposServices{

  //GET Predio
  Future<List<CamposFicha>> getCamposFicha(id) async {
    final response = await http.get("https://desarrollosigm.ibarra.gob.ec/apimv/rest/getCamposFichaById.php?cc="+id);
    //print("Si entra");
    List<CamposFicha> inspeccion = [];

    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      // Convertir a json
      final jsonData = jsonDecode(body);

      for (var item in jsonData) {
        inspeccion.add(CamposFicha(
          item["fic_id"],
          item["fic_id_ficha"],
          item["fic_nombre"],
          item["fic_descripcion"],
          item["fic_tipo"],
          item["fic_tipo_opcion"],
          item["fic_orden"]
        ));
      }
      print(jsonData); 
      return inspeccion;
    } else {
      throw Exception("Fallo la conexión");
    }
  }
}