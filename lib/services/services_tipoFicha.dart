import 'package:flutter_webview_predioibarra/models/tipo_ficha/tipo_ficha.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TipoFichaServices{

  //GET Predio
  Future<List<TipoFicha>> getTipoFicha() async {
    final response = await http.get("https://desarrollosigm.ibarra.gob.ec/apimv/rest/getTipoFicha.php");
    //print("Si entra");
    List<TipoFicha> tipoFicha = [];

    if (response.statusCode == 200){
      String body = utf8.decode(response.bodyBytes);
      // Convertir a json
      final jsonData = jsonDecode(body);

      for (var item in jsonData) {
        tipoFicha.add(TipoFicha(
          item["fit_id"],
          item["fit_nombre"],
          item["fit_descripcion"],
          item["fit_departamento"]
        ));
      }
      //print(jsonData); 
      return tipoFicha;
    } else {
      throw Exception("Fallo la conexión");
    }
  }
}