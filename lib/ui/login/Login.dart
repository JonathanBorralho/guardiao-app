import 'dart:convert';

import 'package:guardiao_mobile/service/GuardiaoService.dart';
import 'package:guardiao_mobile/service/AuthService.dart';

import 'package:guardiao_mobile/ui/login/style/theme.dart' as Theme;
import 'package:guardiao_mobile/ui/home/Home.dart';

import 'package:guardiao_mobile/model/Auth.dart';

import 'package:guardiao_mobile/util/Util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;


class Login extends StatefulWidget {

  final String messenger;
  Login({this.messenger});

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {

  final AuthService authService                         = new AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey           = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _formKey               = new GlobalKey<ScaffoldState>();

  TextEditingController loginTituloEleitoralController  = new TextEditingController();
  TextEditingController loginPasswordController         = new TextEditingController();

  bool _obscureTextLogin                                = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 191.0,
                      fit: BoxFit.contain,
                      image: new AssetImage('assets/img/icon_brasao.gif')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Text("TRE/MA", style: new TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 25.0
                  ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: new Text("GUARDIÃO", style: new TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 25.0, color: Util.hexToColor("#347CAB")
                  ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                   children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: loginTituloEleitoralController,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter some text';
                            }
                          },
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Título eleitoral...",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Please enter some text';
                            }
                          },
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Senha...",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                Icons.remove_red_eye,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () => _onSignInButtonPress(context, loginTituloEleitoralController, loginPasswordController)),//.(context, loginEmailController, loginPasswordController)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress(BuildContext context, TextEditingController loginTituloEleitoralController, TextEditingController loginPasswordController) {
    if(loginPasswordController.value.text == '' || loginTituloEleitoralController.value.text == ''){
      showInSnackBarError("Título de Eleitor e/ou Senha são obrigatórios!");
    }else{
      login(context, loginTituloEleitoralController, loginPasswordController);
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void login(BuildContext context, TextEditingController loginTituloEleitoralController, TextEditingController loginPasswordController) async {
    var url = "http://localhost:8080/guardiaomobile/login/";
    var body = {"login": loginTituloEleitoralController.value.text, "senha": loginPasswordController.value.text};

     http.post(url, body: body).then((response) {
       if(response.statusCode == 200){
        var temp = jsonDecode(response.body);
        saveToken(new Auth(temp["jwt"]));
      }

      if(response.statusCode == 500){
        showInSnackBarError("Erro ao gerar token!");
      }

     if(response.statusCode == 401){
       showInSnackBarError("Usuário e/ou senha inválidos!");
     }

    });
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

}
