import 'package:flutter_webview_predioibarra/shared_preferences/preferences_cabecera.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webview_predioibarra/models/post_campos/cabecera.dart';

class ServicesCabecera{

  Future<Cabecera> postCabecera(Cabecera cabecera) async{
    //print("Cabecera: "+cabecera.fii_id_ficha+cabecera.fii_usuario+cabecera.fii_comentario+cabecera.fii_observaciones);
    //var body = jsonEncode(cabecera.toJason());
    var body = cabecera.toJason();

    var url = Uri.parse("http://desarrollosigm.ibarra.gob.ec/apimv/rest/processFichaInspeccionInfo.php");

    final response = await http.post(url,
    headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: body
    );

    //print(response.request);
    print(response.statusCode);
    print("response.body"+response.body); 

    final jsonObject = json.decode(response.body);
    String fii_id = jsonObject["fii_id"];
    //print("JsonObject: "+jsonObject);
    if (response.statusCode == 200){
      PreferencesCabecera.setFiiId(fii_id);
      var x =PreferencesCabecera.getFiiId();
      print("Preferences"+x);
      print(fii_id);
      return Cabecera.fromJson(jsonObject);
      
    } else {
      throw Exception("Fallo post");
    }

  }

}