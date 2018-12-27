import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:guardiao_mobile/model/Auth.dart';
import 'package:guardiao_mobile/service/AuthService.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/ui/home/Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginData {
  String tituloEleitor = '';
  String password = '';
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController tituloController  = new TextEditingController();
  TextEditingController senhaController  = new TextEditingController();

  _LoginData _data                    = new _LoginData();
  final AuthService authService       = new AuthService();

  String _validateTituloEleitor(String value) {
    if (value.length <= 0) {
      return 'O campo *Título de Eleitor* é obrigatório!';
    }

    if(value.length > 12){
      return 'O campo *Título de Eleitor* é inválido!';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length <= 0) {
      return 'O campo *Senha* é obrigatório!';
    }
    return null;
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      login(this.tituloController.value.text, this.senhaController.value.text);
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
      key: this._scaffoldKey,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Login'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        icon: new Icon(Icons.person),
                        hintText: '000011113333',
                        labelText: 'Título de Eleitor'
                    ),
                    validator: this._validateTituloEleitor,
                    controller: this.tituloController,
                    onSaved: (String value) {
                      this._data.tituloEleitor = value;
                    }
                ),
                new TextFormField(
                    obscureText: true, // Use secure text for passwords.
                    decoration: new InputDecoration(
                        icon: new Icon(Icons.lock),
                        hintText: 'Senha',
                        labelText: 'Digite sua senha'
                    ),
                    validator: this._validatePassword,
                    controller: this.senhaController,
                    onSaved: (String value) {
                      this._data.password = value;
                    }
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Login',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
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

  void saveToken(auth) async{
    int idAuth = await authService.saveAuth(auth);
    await authService.dbHelper.close();

    if(idAuth != null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => new Home()));
    }else{
      showInSnackBarError("Erro ao salvaor Token! Tente novamente ou abra um chamado na Central TI!");
    }
  }

  void login(String usuario, String senha) async {
    var url = "http://localhost:8080/guardiaomobile/login/";
    var body = {"login": usuario, "senha": senha};

    http.post(url, body: body).then((response) {
      if (response.statusCode == 200) {
        var temp = jsonDecode(response.body);
        saveToken(new Auth(temp["jwt"]));
      }

      if (response.statusCode == 500) {
        showInSnackBarError("Erro ao gerar token!");
      }

      if (response.statusCode == 401) {
        showInSnackBarError("Usuário e/ou senha inválidos!");
      }
    });
  }
}