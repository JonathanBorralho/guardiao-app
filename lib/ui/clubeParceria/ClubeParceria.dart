import 'package:flutter/material.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/model/Sistema.dart';
import 'package:guardiao_mobile/ui/clubeParceria/Parcerias.dart';
import 'package:guardiao_mobile/ui/clubeParceria/Menu.dart';

class ClubeParceria extends StatefulWidget {

  final Sistema sistema;
  ClubeParceria({this.sistema});

  @override
  _ClubeParceriaState createState() => _ClubeParceriaState();
}

class _ClubeParceriaState extends State<ClubeParceria> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(widget.sistema.nome),
          centerTitle: true,
          backgroundColor: hexToColorSystem(widget.sistema.cor),
      ),
      drawer: Menu(context, widget.sistema),
      body: Container(
        child: 
          Padding(
              padding: EdgeInsets.all(55.0),
              child: Image.asset('assets/img/brasaoTREMA.png')
          ),
      ),
    );
  }
}
