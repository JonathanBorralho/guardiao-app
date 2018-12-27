import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/ui/login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationData {
  String codeAuth = '';
  String matricula = '';
}

class _AuthenticationState extends State<Authentication> {

  final GlobalKey<FormState> _formKey                   = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey           = new GlobalKey<ScaffoldState>();
  _AuthenticationData _data                             = new _AuthenticationData();
  bool _obscureTextLogin                                = true;

  TextEditingController matriculaController  = new TextEditingController();
  TextEditingController codigoController  = new TextEditingController();

  String _validateCode(String value) {
    if (value.length <= 0) {
      return 'O campo *Código de Autenticação* é obrigatório!';
    }
    return null;
  }

  String _validateMatricula(String value) {
    if (value.length <= 0) {
      return 'O campo *Matrícula* é obrigatório!';
    }
    return null;
  }

  _saveAuthorization(String valido) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('valido', valido);
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      var url = "http://localhost:8080/guardiaomobile/autenticacao/";
      var body = {"matricula": matriculaController.value.text, "codeAuth": codigoController.value.text};

      http.post(url, body: body).then((response) {
        if (response.statusCode == 200) {
          var temp = jsonDecode(response.body);
          _saveAuthorization(temp["resCodeAuth"]);


          Navigator.push(context, MaterialPageRoute(builder: (context) => new Login()));

          //print(temp["resCodeAuth"]);
        }

        if (response.statusCode == 401) {
          showInSnackBarError("Código de Autenticação inválido!");
        }

        if (response.statusCode == 400) {
          showInSnackBarError("Código de Autenticação já utilizado!");
        }
      });
    }
  }

  void showInSnackBarError(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Util.hexToColor("#bd362f"),
      duration: Duration(seconds: 6),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
      title: new Text('Autenticação'),
      centerTitle: true,
    ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.person),
                      hintText: 'Digite aqui sua matrícula',
                      labelText: 'Matrícula'
                  ),
                  validator: this._validateMatricula,
                  controller: matriculaController,
                  onSaved: (String value){
                    this._data.matricula = value;
                  },
                ),
                new TextFormField(
                    decoration: new InputDecoration(
                      icon: new Icon(Icons.lock),
                        hintText: 'Digite aqui o código de autenticação',
                        suffixIcon: GestureDetector(
                          onTap: _toggleLogin,
                          child: Icon(
                            Icons.remove_red_eye,
                            size: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        labelText: 'Código de Autenticação'
                    ),
                  validator: this._validateCode,
                  controller: codigoController,
                  onSaved: (String value){
                      this._data.codeAuth = value;
                  },
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Enviar autenticação',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () => this.submit(),
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

}


