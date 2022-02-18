import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:conversor_de_moedas/pages/home.dart';

const request = 'https://api.hgbrasil.com/finance?format=json&key=1a93bd96';

void main(List<String> args) async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(

    ),
  ));
}

Future<Map> getData() async {
  var url = Uri.parse(request);
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
