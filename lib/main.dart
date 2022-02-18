import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:conversor_de_moedas/pages/home.dart';

const request = 'https://api.hgbrasil.com/finance?format=json&key=1a93bd96';

void main(List<String> args) async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  try {
    var url = Uri.parse(request);
    http.Response response = await http.get(url);
    return json.decode(response.body);
  } on Exception catch (e) {
    throw HttpException(e.toString());
  }
}
