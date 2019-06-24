import 'package:flutter/material.dart';
import 'package:guardiao_mobile/ui/home/Menu.dart';

class CarteiraFuncional extends StatefulWidget {
  @override
  _CarteiraFuncionalState createState() => _CarteiraFuncionalState();
}

class _CarteiraFuncionalState extends State<CarteiraFuncional> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Carteira Funcional'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Menu(context),
      body: Container(
      ),
    );
  }
}
