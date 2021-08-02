import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_cabecera.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_login.dart';
import 'package:flutter_webview_predioibarra/views/login/view_login.dart';
import 'package:flutter_webview_predioibarra/views/view_inicio/web_viewCatastro.dart';
import 'package:flutter_webview_predioibarra/views/view_predio.dart';
import 'package:flutter_webview_predioibarra/views/view_tipoFicha.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesLogin.init();
  await PreferencesCabecera.init();
  runApp(MaterialApp(
    routes: {
      '/login': (context) => ViewLogin(),
      '/inicio': (context) => HomeView(),
      '/tipoFicha': (context) => ViewTipoFicha(),
      },
      initialRoute: PreferencesLogin.getUser() == null ? '/login' : '/inicio',
  ));
}