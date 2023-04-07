import 'package:apiwithflutter/model/akunmodel.dart';
import 'package:apiwithflutter/screen/mainpage.dart';
import 'package:apiwithflutter/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/linkapi.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    bool cek = false;


    Future<void> checkdata(String email,String password)async{
      try{
        final endpoint = Uri.parse("${Apilink.BASE_URL}/akun/login");
        final response = await http.post(endpoint,body: {
          "email": email,
          "password": password
      });
      print("from ceck");

      if(response.statusCode == 200){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "CRUD",)));
        // return Akundata.fromJson(jsonDecode(response.body));
      }else {
        throw Exception('Failed to check.');
      }
      }catch(e){
        cek = true;
        print(cek);
      }

    }



    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("username"),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "inset email"),
            ),
            Text("password"),
            TextField(
              controller: pass,
              decoration: InputDecoration(hintText: "inset password"),
            ),
            ElevatedButton(onPressed: () {
               final getEmail = email.text;
              final getPass = pass.text;
              checkdata(getEmail, getPass);
          
            }, child: Text("Submit")),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
            }, child: Text("Register")),
            Visibility(
              visible: cek,
              child: Text("salah input akun"))
          ],
        ),
      ),
    );
  }
}
