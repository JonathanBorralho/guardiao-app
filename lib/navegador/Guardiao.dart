import 'package:flutter/material.dart';
import 'package:guardiao_mobile/ui/home/Home.dart';
import 'package:guardiao_mobile/ui/login/Login.dart';

class Guardiao{

 static void index (BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => new Home()));
  }

 static void login (BuildContext context, String messenger){
   Navigator.push(context, MaterialPageRoute(builder: (context) => new Login(messenger: messenger,)));
 }

}

