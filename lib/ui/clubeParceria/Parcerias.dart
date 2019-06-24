import 'package:flutter/material.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/model/Sistema.dart';
import 'package:guardiao_mobile/ui/clubeParceria/Menu.dart';
import 'package:guardiao_mobile/ui/clubeParceria/DetalheParceria.dart';
import 'package:guardiao_mobile/model/Parceria.dart';
import 'dart:convert';
import 'dart:async';
import 'package:guardiao_mobile/json/TokenHttp.dart';


class Parcerias extends StatefulWidget {

  final Sistema sistema;
  Parcerias({this.sistema});

  @override
  _ParceriasState createState() => _ParceriasState();
}

class _ParceriasState extends State<Parcerias> {

  TextEditingController controller = new TextEditingController();
  String filter;
  List<Parceria> parcerias;
  final TokenHttp tokenHttp        = new TokenHttp();

  Future<List<Parceria>> getJSON() async {
    var url = "http://localhost:8080/guardiaomobile/clubeparceria/parcerias";
    tokenHttp.get(url).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> temp = jsonDecode(response.body);
          List temp2 = temp["list"];
          parcerias = temp2.map( (d) => new Parceria.fromJson(d)).toList();
          parcerias.sort(
                  (a, b){
                return a.nomeParceria.toLowerCase().compareTo(b.nomeParceria.toLowerCase());
              });
        });
      }
      if (response.statusCode == 401) {

      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getJSON();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
      this.getJSON();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
        new AppBar(
          centerTitle: true,
          title:Column(children: [
            Text(widget.sistema.nome),
            GestureDetector(
              child: Text('Parcerias'),
              onTap: () {},
            )
          ]),
          backgroundColor: hexToColorSystem(widget.sistema.cor),
        ),
      drawer: Menu(context, widget.sistema),
      body: new Container(
        color: Colors.white,
        child: new Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.all(20.0),
                child: new TextField(
                  decoration: new InputDecoration(
                    labelText: "Filtrar parcerias...",
                    icon: new Icon(Icons.zoom_in),
                  ),
                  controller: controller,
                ),
              ),
              new Expanded(
                child: new ListView.builder(
                    itemCount: (parcerias == null || parcerias.isEmpty) ? 0 : parcerias.length,
                    itemBuilder: (BuildContext context, int position) {
                      retornaListaParcerias(widget.sistema, parcerias, position, context);
                      return filter == null || filter == "" ? retornaListaParcerias(widget.sistema, parcerias, position, context)
                          : (parcerias[position].nomeParceria.toLowerCase().startsWith(filter.toLowerCase())
                          || parcerias[position].nomeParceria.toLowerCase().contains(filter.toLowerCase())
                          || parcerias[position].bairro.toLowerCase().contains(filter.toLowerCase())
                          || parcerias[position].bairro.toLowerCase().startsWith(filter.toLowerCase())
                          || parcerias[position].retornaRamoAtividade().toLowerCase().contains(filter.toLowerCase())
                          || parcerias[position].retornaRamoAtividade().toLowerCase().startsWith(filter.toLowerCase())
                      )  ?
                      retornaListaParcerias(widget.sistema, parcerias, position, context) : new Column();
                    }
                ),
              )
            ]
        ),
      ),
    );
  }
}

Column retornaListaParcerias(Sistema sistema, List<Parceria> parcerias, int position, BuildContext context){
  return new Column(
    children: <Widget>[
      new Divider(height: 5.5),
      new ListTile(
        title: Text(
          "${parcerias[position].nomeParceria}",
          style: new TextStyle(
              fontSize: 19.9,
              color: Colors.black,
              fontWeight: FontWeight.w800),
        ),
        subtitle: new Row(
          children: <Widget>[
            Text(parcerias[position].retornaRamoAtividade(),
                style: new TextStyle(
                    fontSize: 13.9,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic)),
          ],
        ),
        leading: new CircleAvatar(
          radius: 30.0,
          //backgroundColor: hexToColor("#008E2C"),
          backgroundImage: NetworkImage(parcerias[position].logomarcaUrl),
          /*child: Text(
            "${position+1}".toUpperCase(),
            style: new TextStyle(
                fontSize: 16.4,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          ),*/
        ),
        onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context) =>
        new DetalheParceria(sistema: sistema, parceria: parcerias[position])));},
      )
    ],
  );
}
