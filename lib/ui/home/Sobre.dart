import 'package:flutter/material.dart';
import 'package:guardiao_mobile/ui/home/Menu.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Guardião'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Menu(context),
      body: Container(

      ),
    );
  }
}
