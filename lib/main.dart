import 'dart:convert';
import 'package:apiwithflutter/model/data.dart';
import 'package:apiwithflutter/model/datamodel.dart';
import 'package:apiwithflutter/screen/login.dart';
import 'package:apiwithflutter/screen/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

