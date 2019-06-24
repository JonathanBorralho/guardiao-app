import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guardiao_mobile/ui/authentication/Authentication.dart';
import 'package:guardiao_mobile/ui/login/Login.dart';

final pages = [
  new PageViewModel(
      const Color(0xFF548CFF),
      'assets/img/logoTRE01.png',
      '',
      'Bem-vindo ao Guardião, aplicativo oficial e portal de acesso aos sistemas do TRE/MA!',
      'assets/img/icon_brasao.gif',
      true),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;


  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

   _getAuthorization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String autorizacao = prefs.getString('valido');
    return autorizacao;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child:
            new Opacity(
              opacity: percentVisible,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          new Transform(
            transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible) ,0.0),
            child: new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 75.0, 0.0),
                child:
                new Image.asset(
                    viewModel.heroAssetPath,
                    width: 300.0,
                    height: 300.0),
            ),
          ),
          new Transform(
            transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
            child: new Padding(
                padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Text(
                  viewModel.title,
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'FlamanteRoma',
                    fontSize: 34.0,
                  ),
                ),
            ),
          ),
          new Transform(
            transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
            child: new Padding(
                padding: new EdgeInsets.only(bottom: 75.0),
                child: new Text(
                  viewModel.body,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: 'FlamanteRomaItalic',
                    fontSize: 18.0,
                  ),
                ),
            ),
          ),
          new Transform(
            transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible) ,0.0),
            child: new Padding(
              padding: new EdgeInsets.only(bottom: 60.0),
              child: new RaisedButton(
                child: const Text('Ir para o Guardião!'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed: () async {
                  String autorizacao = await _getAuthorization();
                  if(autorizacao == '1'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Login()));
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Authentication()));
                  }
                },
              ),
            ),
          ),
        ]),
            ));

  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;
  final bool lastScreen;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
      this.lastScreen
  );
}
