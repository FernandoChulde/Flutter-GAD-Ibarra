import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webview_predioibarra/models/predio/predio.dart';

class PredioServices{

  //GET Predio
  Future<List<Predio>> getPredio(clave) async {
    final response = await http.get("https://desarrollosigm.ibarra.gob.ec/apimv/rest/getPredioByClaveCatastral.php?cc="+clave);
    //print("Si entra");
    List<Predio> predio = [];

    if (response.statusCode == 200) {
      // Evitar error de sintaxis en la vista con palabras con tiles, ñ, etc...
      String body = utf8.decode(response.bodyBytes);
      // Convertir a json
      final jsonData = jsonDecode(body);
      //print(jsonData[0]["clave_cat"]);
      // Recorre data y añade los datos en la lista
      for (var item in jsonData) {
        predio.add(Predio(
          item["clave_cat"],
          item["predialant"],
          item["tipo_predio"],
          item["propiedad"],
          item["calle"],
          item["calle_s"],
          item["nombre_urb"],
          item["numero_vivienda"],
          item["area_solar"],
          item["area_declarada_const"],
          item["avaluo_solar"],
          item["avaluo_construccion"],
          item["avaluo_obra_complement"],
          item["avaluo_municipal"],
          item["num_lote"],
          item["num_manzana"],
          item["ficha_madre"],
          item["propiedad_horizontal"],
          item["alicuota_terreno"],
          item["ced_ruc_propietario"],
          item["nombre_propietario"]
          )
        );
      }
      //print(jsonData);
      //print(predio);
      return predio;
    } else {
      throw Exception("Fallo la conexión");
    }
  }

}