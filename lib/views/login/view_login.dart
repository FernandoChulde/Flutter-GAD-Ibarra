import 'package:flutter/material.dart';
import 'package:flutter_webview_predioibarra/models/login/login.dart';
import 'package:flutter_webview_predioibarra/services/services_login/services_login.dart';
import 'package:flutter_webview_predioibarra/shared_preferences/preferences_login.dart';

class ViewLogin extends StatefulWidget {
  //Login({Key? key}) : super(key: key);

  @override
  _ViewLoginState createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  TextEditingController controllUser;
  TextEditingController controlPasword;
  String name = "";
  Login login;

  @override
  void initState() {
    super.initState();
    controllUser = new TextEditingController();
    controlPasword = new TextEditingController();
    login = new Login();
    name = PreferencesLogin.getUser() ?? '';
    //autLogin();
  }

  void autLogin(){
    if(PreferencesLogin.getUser()!= null){
      controllUser.text = PreferencesLogin.getUser();
      controlPasword.text = PreferencesLogin.getPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                'images/Ibarra.png',
                height: 200.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            _userTextField(),
            SizedBox(
              height: 15,
            ),
            _passwordTextField(),
            SizedBox(
              height: 15.0,
            ),
            _bottonLogin(),
            // TextFormField(
            //   controller: controllUser,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(), hintText: "Ingrese el nombre"),
            // ),
            // SizedBox(height: 10),
            // TextFormField(
            //   controller: controlPasword,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(), hintText: 'Ingrese contraseña'),
            // ),
            // SizedBox(height: 10),
            // ElevatedButton(
            //     onPressed: () {
            //       login.us = controllUser.text;
            //       login.pw = controlPasword.text;
            //       LoginServices loginServices = new LoginServices();
            //       setState(() {
            //         loginServices.postLogin(context, login);
            //         //postLogin(login);
            //       });
            //     },
            //     child: Text("Ingresar"))
          ],
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          controller: controllUser,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'ejemplo usuario',
            labelText: 'Usuario',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          controller: controlPasword,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          // onTap: () {
          //   login.us = controllUser.text;
          //   login.pw = controlPasword.text;
          //   LoginServices loginServices = new LoginServices();
          //   setState(() {
          //     loginServices.postLogin(context, login);
          //     //postLogin(login);
          //   });
          // },
          //onChanged: (value) {},
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          login.us = controllUser.text;
          login.pw = controlPasword.text;
          LoginServices loginServices = new LoginServices();
          setState(() {
            loginServices.postLogin(context, login);
            //postLogin(login);
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Text('Iniciar Sesion'),
        ),
      );
    });
  }
}
