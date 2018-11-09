import 'dart:ui';
import 'package:guardiao_mobile/util/Util.dart';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();


  static Color loginGradientStart = Util.hexToColor("#FFFFFF");
  static Color loginGradientEnd = Util.hexToColor("#347CAB");

  static final primaryGradient =  LinearGradient(
    colors:  [loginGradientStart, loginGradientEnd],
    stops:  [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}