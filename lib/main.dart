import 'package:flutter/material.dart';
import 'package:guardiao_mobile/ui/preview/Preview.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Guardião - TRE/MA',
      debugShowCheckedModeBanner: false,

      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Preview(),
    );
  }

}



