import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerHome extends StatefulWidget {
  //Drawer({Key? key}) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  
  String name ="";

  //PreferencesLogin

  @override
  void initState() { 
    super.initState();
    name = PreferencesLogin.getUser() ?? '';
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
       child: ListView(
         padding: EdgeInsets.zero,
         children: [
           _Header(),
           _Home(),
           Divider(),
           _Logout()
         ],
       ),
    );
  }

  Widget _Header(){
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.red
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500
              ),
            )
          )
        ],
      ));
  }

  Widget _Logout(){
    return ListTile(
      title: Text("Cerrar Sesión"),
      leading: Icon(Icons.logout),
      onTap: () async {
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushNamed(context, '/login');
      },
    );
  }

  Widget _Home(){
    return ListTile(
      title: Text("Inicio"),
      leading: Icon(Icons.home),
      onTap: (){
        Navigator.pushNamed(context, '/inicio');
      },
    );
  }
}