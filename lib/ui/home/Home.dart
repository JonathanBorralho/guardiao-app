import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:guardiao_mobile/util/Util.dart';

import 'package:guardiao_mobile/model/Sistema.dart';

import 'package:guardiao_mobile/ui/clubeParceria/ClubeParceria.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String filter;
  List<Sistema> sistemas;

  void getJSON() async {
    var url = "http://localhost:8080/guardiaomobile/sistemas/";
    http.get(url).then((response) {
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
      backgroundColor: Colors.teal,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('Sistemas'),
      ),
      body: new GridView.builder(
          itemCount: (sistemas == null || sistemas.isEmpty) ? 0 : sistemas.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              color: Util.hexToColorSystem(sistemas[index].cor),
              elevation: 5.0,
              child: new Container(
                alignment: Alignment.center,
                child: new Text('${sistemas[index].sigla}'),
              ),
            ),
            onTap: (){
              redirecionarSistema(context, sistemas[index]);
            },
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
