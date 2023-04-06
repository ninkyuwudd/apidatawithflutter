import 'dart:convert';
import 'package:apiwithflutter/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/akunmodel.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final id = TextEditingController();
    final username = TextEditingController();
    final email = TextEditingController();
    final pass = TextEditingController();
    

    Future<void> adddatauser(
        String number, String username, String email, String password) async {
      final endpoint = Uri.parse("http://192.168.32.242:3300/akun/register");
      final response = await http.post(endpoint, body: {
        'id': number,
        "username": username,
        "email": email,
        "password": password
      });
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      //  return Akundata.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create akun.');
      }
      
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        actions: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));;
          }, child: Text("Login"))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("id"),
            TextField(
              controller: id,
              decoration: InputDecoration(hintText: "inset email"),
            ),
            Text("username"),
            TextField(
              controller: username,
              decoration: InputDecoration(hintText: "inset email"),
            ),
            Text("email"),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "inset email"),
            ),
            Text("password"),
            TextField(
              controller: pass,
              decoration: InputDecoration(hintText: "inset password"),
            ),
            TextButton(onPressed: () {
              final getid = id.text;
              final getname = username.text;
              final getemail = email.text;
              final getpassword = pass.text;

              adddatauser(getid, getname, getemail, getpassword);

            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
