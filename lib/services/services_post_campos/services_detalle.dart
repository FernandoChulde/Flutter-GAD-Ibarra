import 'package:flutter_webview_predioibarra/models/post_campos/detalle.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ServicesDetalle{

  Future<Detalle> postDetalle(Detalle detalle) async{
    var body = detalle.toJason();
    var url = Uri.parse("http://desarrollosigm.ibarra.gob.ec/apimv/rest/processFichaInspeccionInfoDetalle.php");

    final response = await http.post(url,
    headers: {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'},
    body: body
    );

    //print(response.request);
    print(response.statusCode);
    print("Cuerpo"+response.body);

    final jsonObject = json.decode(response.body);
    //print("JsonObject: "+jsonObject);
    if (response.statusCode == 200){
      print(jsonObject);
      return Detalle.fromJson(jsonObject);
      
    } else {
      throw Exception("Fallo post");
    }
  }

}