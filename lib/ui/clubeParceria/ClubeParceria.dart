import 'package:flutter/material.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/model/Sistema.dart';
import 'package:guardiao_mobile/ui/clubeParceria/Parcerias.dart';

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
          backgroundColor: Util.hexToColorSystem(widget.sistema.cor),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('Raja'),
              decoration: BoxDecoration(color: Util.hexToColorSystem(widget.sistema.cor)),
              accountEmail: new Text(widget.sistema.sigla),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
              ),
            ),
            new ListTile(
              title: new Text('Parcerias'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                new Parcerias(sistema: widget.sistema,)));
              },
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        ),
      ),
    );
  }
}
