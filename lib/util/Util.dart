import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

  Color hexToColor(String code) {
    if(code != ""){
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }else{
      return Colors.black;
    }
  }

  Color hexToColorSystem(String code) {
    if(code != ""){
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }else{
      return Colors.black;
    }
  }

  void launchInstagram(String instagram){
    var instagramUrl = "https://www.instagram.com/$instagram";
    launch("${instagramUrl}");
  }

  void launchWhatsApp (String whatsapp, BuildContext context) async{
    var whatsappUrl ="whatsapp://send?phone=+55$whatsapp";
    await canLaunch(whatsappUrl)? launch(whatsappUrl): alertError("", context);
  }

  void alertError(String message, BuildContext context){
    var alert = new AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      title: Text("Você não possui o WhatsApp instalado!"),
      content: new Column(),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          }, )
      ],
    );
    // showDialog(context: context, child: alert);
    showDialog(context: context, builder: (context) => alert);
  }

