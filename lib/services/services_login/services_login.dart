import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_predioibarra/models/login/login.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginServices{

  // String session;
  // String usuario;

  Future<Login> postLogin(context,Login login) async {
    var body = login.toJson();

    var url = Uri.parse(
        "http://desarrollosigm.ibarra.gob.ec/apimv/rest/getAutentificacion.php");

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
        body: body);

    //print(response.statusCode);
    
    final jsonObject = json.decode(response.body);
    final res = jsonObject["result"][0]["usuario"];

    if (response.statusCode == 200 && res == "1") {
      // print(login.us);
      // print(login.pw);
      bool isSession = true;
      PreferencesLogin.setUser(login.us);
      PreferencesLogin.setPasword(login.pw);
      PreferencesLogin.setSession(isSession);
      //getSesion(isSession, login.us);
      Navigator.pushNamed(context, '/inicio');

      return Login.fromJson(jsonObject);
    } else {
      
      throw Exception("Fallo ingreso");
      
    }
  }

  // Future<void> getSesion(bool session, String usuario) async{
  //   //print("entra"+session.toString()+usuario);
  //   SharedPreferences.setMockInitialValues({});
  //   SharedPreferences prefs= await SharedPreferences.getInstance();
  //   await prefs.setBool('session', session);
  //   await prefs.setString('usuario', usuario);
  // }


  // Future<void> readSession() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   session = await prefs.getString('session');
  //   usuario = await prefs.getString('usuario');

  //   print("preference login: "+session);
  //   print(usuario);
  // }
}