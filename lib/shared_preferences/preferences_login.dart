import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLogin{

  static SharedPreferences prefs;
  static const _usuario= 'usuario';
  static const _sesion= 'sesion';
  static const _password = 'password';

  static Future init() async{
    prefs = await SharedPreferences.getInstance();
  }

  static Future setUser(String usuario) async => await 
    prefs.setString(_usuario, usuario);

  static String getUser() => prefs.getString(_usuario);

  static Future setPasword(String pasword) async => await
    prefs.setString(_password, pasword);

  static String getPassword() => prefs.getString(_password);

  static Future setSession(bool sesion) async => await
    prefs.setBool(_sesion, sesion);

  static bool getSession() => prefs.getBool(_sesion);

  //static Future removeUsser() => prefs.clear(true);
}