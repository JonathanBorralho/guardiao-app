import 'package:flutter/material.dart';
import 'package:guardiao_mobile/model/Sistema.dart';
import 'package:guardiao_mobile/util/Util.dart';
import 'package:guardiao_mobile/ui/clubeParceria/Parcerias.dart';
import 'package:guardiao_mobile/ui/clubeParceria/ClubeParceria.dart';

Drawer Menu(BuildContext context, Sistema sistema){
  return new Drawer(

    child: ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text('Raja'),
          decoration: BoxDecoration(color: hexToColorSystem(sistema.cor)),
          accountEmail: new Text(sistema.nome),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: new NetworkImage(sistema.iconeUrl),
          ),
        ),
        new ListTile(
          title: new Text('Inicio'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
            new ClubeParceria(sistema: sistema)));
          },
        ),
        new ListTile(
          title: new Text('Parcerias'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
            new Parcerias(sistema: sistema)));
          },
        ),
        new ListTile(
          title: new Text('Sobre'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}