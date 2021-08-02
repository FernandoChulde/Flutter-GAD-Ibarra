import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_predioibarra/services/services_login/services_login.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_login.dart';
import 'package:flutter_webview_predioibarra/views/view_campos/view_get_campos.dart';
import 'package:flutter_webview_predioibarra/views/view_inicio/drawer.dart';
import 'package:flutter_webview_predioibarra/views/view_predio.dart';
import 'package:flutter_webview_predioibarra/views/view_tipoFicha.dart';
import 'package:flutter_webview_predioibarra/views/view_zonificacion.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  InAppWebViewController _webViewController;
  TextEditingController claveSeleccionada;

  bool sesion;
  String usuario;

  String url = "https://desarrollosigm.ibarra.gob.ec/sigm8/mvMaps/";
  ContextMenu contextMenu;
  double progress = 0;

  // Future<void> readSession() async{
  //   //SharedPreferences.setMockInitialValues({});
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   sesion = prefs.getBool('session');
  //   usuario = prefs.getString('usuario');

  //   print(usuario);

  //   // print(isSession);
  //   // print("preference : "+usuario);

  //   //return isSession;
  // }

  //PreferencesLogin preferenceLogin = new PreferencesLogin();

  // Espera respuesta de permiso
  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location].request();
    // print(statuses[Permission.location]);
  }

  // Solicita permisos
  void permisoUbicacion(InAppWebViewController _webViewController) async {
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await _webViewController.getSelectedText());
                await _webViewController.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: true),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await _webViewController.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });
  }

  // Constructor que se ejecuta al iniciar la app
  @override
  void initState() {
    super.initState();
    requestPermission();
    this.permisoUbicacion(_webViewController);
    claveSeleccionada = new TextEditingController();
    //print("pref: "+preferenceLogin.readSession());
    //print("usuario: "+preferenceLogin.session());
    //print("user: "+usuario);
    //print(preferenceLogin.readSession().asStream());
    usuario = PreferencesLogin.getUser() ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainAppBar(),
      drawer: DrawerHome(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _logo(),
            _inputClave(),
            _progresoCarga(),
            Expanded(
              child: _webviewMapa(),
            ),
            _barraBotones()
          ],
        ),
      ),
    );
  }

  Widget _mainAppBar() {
    return AppBar(
      actions: [_refreshPagina()],
      title: Text("GAD IBARRA"),
      backgroundColor: Colors.red,
    );
  }

  Widget _refreshPagina() {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          if (_webViewController != null) {
            _webViewController.reload();
          }
        });
  }

  Widget _logo() {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: 110,
        height: 110,
        child: Image.asset(
          "images/Ibarra.png",
          fit: BoxFit.cover,
        ));
  }

  Widget _inputClave() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: Colors.blueGrey,
        controller: claveSeleccionada,
        keyboardType: TextInputType.number,
        maxLength: 24,
        decoration: InputDecoration(
            labelText: "Ingresar clave",
            labelStyle: TextStyle(color: Colors.blueGrey),
            prefixIcon: Icon(
              Icons.border_color,
              color: Colors.blueGrey,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
            )),
      ),
    );
  }

  Widget _progresoCarga() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: progress < 1.0
          ? LinearProgressIndicator(value: progress)
          : Container(),
    );
  }

  Widget _webviewMapa() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
      child: InAppWebView(
        initialUrl: url,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            debuggingEnabled: true,
          ),
          android: AndroidInAppWebViewOptions(),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          setState(() {
            this.url = url;
          });
        },
        onLoadStop: (InAppWebViewController controller, String url) async {
          setState(() {
            this.url = url;
          });
        },
        onProgressChanged:
            (InAppWebViewController controller, int progress) async {
          setState(() {
            this.progress = progress / 100;
          });
        },
      ),
    );
  }

  Widget _barraBotones() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        _botonPredio(),
        _botonZonificacion(),
        _botonTipoFicha()],
    );
  }

  Widget _botonPredio() {
    return ElevatedButton(
        onPressed: () {

          // Navigator.pushNamed(context, '/predio',
          // arguments: {'clave': claveSeleccionada.text});
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewPredio(claveSeleccionada.text),
          ));
        },
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text("Predio"));
  }

  Widget _botonZonificacion() {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewZonificacion(claveSeleccionada.text),
          ));
        },
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text("Zonificación"));
  }

  Widget _botonTipoFicha(){
    return ElevatedButton(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   //builder: (context) => ViewGetCampos(),
          //   builder: (context) => ViewTipoFicha()
          // ));

          Navigator.pushNamed(context, '/tipoFicha');
        },
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text("Fichas"));
  }
}
