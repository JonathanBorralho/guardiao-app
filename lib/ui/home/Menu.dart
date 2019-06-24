import 'package:flutter/material.dart';
import 'package:guardiao_mobile/ui/home/Home.dart';
import 'package:guardiao_mobile/ui/home/CarteiraFuncional.dart';
import 'package:guardiao_mobile/ui/home/Sobre.dart';

Drawer Menu(BuildContext context){
  return new Drawer(
    child: ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text('Raja'),
          decoration: BoxDecoration(color: Colors.blue),
          accountEmail: new Text('Guardião'),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: new NetworkImage('http://i.pravatar.cc/300'),
          ),
        ),
        new ListTile(
          title: new Text('Inicio'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => new Home()));
          },
        ),
        new ListTile(
          title: new Text('Carteira Funcional'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => new CarteiraFuncional()));
          },
        ),
        new ListTile(
          title: new Text('Sobre'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => new Sobre()));
          },
        ),
      ],
    ),
  );
}