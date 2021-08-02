import 'package:shared_preferences/shared_preferences.dart';

class PreferencesCabecera{

  static SharedPreferences prefs;
  static const _fii_id= 'fii_id';

  static Future init() async{
    prefs = await SharedPreferences.getInstance();
  }

  static Future setFiiId(String id) async => await
    prefs.setString(_fii_id, id);

  static String getFiiId() => prefs.getString(_fii_id);
}