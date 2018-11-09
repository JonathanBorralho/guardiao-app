import 'package:flutter/material.dart';
import 'package:guardiao_mobile/ui/login/Login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Guardião - TRE/MA',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Login(),
    );
  }
}
