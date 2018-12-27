import 'package:flutter/material.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/model/Sistema.dart';

class Parcerias extends StatefulWidget {

  final Sistema sistema;
  Parcerias({this.sistema});

  @override
  _ParceriasState createState() => _ParceriasState();
}

class _ParceriasState extends State<Parcerias> {

  /*TextEditingController controller = new TextEditingController();
  String filter;
  List<Parceria> parcerias;*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
        new AppBar(
        title: new Text('Clube de Parcerias'),
        centerTitle: true,
        backgroundColor: Util.hexToColorSystem(widget.sistema.cor),
    ),
    );
  }
}
