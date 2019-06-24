import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:guardiao_mobile/json/TokenHttp.dart';
import 'package:guardiao_mobile/util/Util.dart';

import 'package:guardiao_mobile/model/Sistema.dart';

import 'package:guardiao_mobile/ui/clubeParceria/ClubeParceria.dart';
import 'package:guardiao_mobile/ui/home/Menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String filter;
  List<Sistema> sistemas;
  final TokenHttp tokenHttp       = new TokenHttp();

  void getJSON() async {
    var url = "http://localhost:8080/guardiaomobile/sistemas/";

    tokenHttp.get(url).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> temp = jsonDecode(response.body);
          print(temp["list"]);
          List temp2 = temp["list"];
          sistemas = temp2.map( (d) => new Sistema.fromJson(d)).toList();
          sistemas.sort(
                  (a, b){
                return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
              });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getJSON();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Sistemas'),
      ),
        drawer: Menu(context),
      body: new GridView.builder(
          itemCount: (sistemas == null || sistemas.isEmpty) ? 0 : sistemas.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Card(
              color: hexToColor(sistemas[index].cor),
              margin: EdgeInsets.all(20.0),
              elevation: 0.0,
              child: Container(
                height: 100.0,
                child: InkWell(
                  splashColor: Colors.black12,
                  onTap: (){redirecionarSistema(context, sistemas[index]);},
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Image.network(sistemas[index].iconeUrl),
                      ),
                      Positioned(
                        bottom: 8.0,
                        left: 16.0,
                        right: 16.0,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            sistemas[index].sigla,
                            style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            onTap: (){},
          );
        },
      )
    );

  }
  void redirecionarSistema(BuildContext context, Sistema sistema){
    if(sistema.id == "93"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => new ClubeParceria(sistema: sistema,)));
    }
  }
}
