import 'package:flutter/material.dart';

class Util{
  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color hexToColorSystem(String code) {
    if(code != ""){
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }else{
      return Colors.white70;
    }

  }
}

