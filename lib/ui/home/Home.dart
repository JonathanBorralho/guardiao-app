import 'package:flutter/material.dart';
import 'package:guardiao_mobile/util/Util.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardião', textAlign: TextAlign.center,),
        backgroundColor: Util.hexToColor("#347CAB"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(20.0),
              child: new TextField(
                decoration: new InputDecoration(
                  labelText: "Filtrar sistemas...",
                  icon: new Icon(Icons.zoom_in),
                ), //controller: controller,
              ),
            ),
            new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Divider(height: 5.5),
                    new Card(
                      color: Colors.yellow,
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.album),
                            title: Text('CLUBE DE PARCERIA', ),
                            subtitle: Text('Sistema Administrativo das Parcerias do TRE/MA'),
                          ),
                        ],
                      ),
                    )
                  ]
                )
            ),
          ],
        ),
      )
    );
  }
}
