import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;


class GuardiaoService {
  void login(BuildContext context, TextEditingController loginTituloEleitoralController, TextEditingController loginPasswordController) async {
    var url = "http://localhost:8080/guardiaomobile/login/";
    var body = {"login": loginTituloEleitoralController.value.text, "senha": loginPasswordController.value.text};

    http.post(url, body: body).then((response) {
      if(response.statusCode == 401){

      }

    });
}
}
