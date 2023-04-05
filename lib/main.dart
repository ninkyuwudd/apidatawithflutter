import 'dart:convert';

import 'package:apiwithflutter/model/data.dart';
import 'package:apiwithflutter/model/datamodel.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Datatest client = Datatest();
  Datamodel? data;

  Future<void> getData() async {
    data = await client.getdatamodel();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> _getdatauser() async {
      var endpoint = Uri.parse("http://192.168.32.242:3300/users");
      var response = await http.get(endpoint);
      print(response.body);
      // var body = jsonDecode(response.body);
      return json.decode(response.body);
    }

    Future<List<dynamic>> _deletedatauser(String? number) async {
      print(number);
      var endpoint = Uri.parse("http://192.168.32.242:3300/users/$number");
      var response = await http.delete(endpoint);
      // var body = jsonDecode(response.body);
      return json.decode(response.body);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: _getdatauser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                    '${snapshot.data[index]["firstname"]} ${snapshot.data[index]["lastname"]}'),
                                subtitle: Text(snapshot.data[index]["phone"]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _deletedatauser(snapshot.data[index]['id']
                                          .toString());
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deletedatauser(snapshot.data[index]['id']
                                          .toString());
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete,color: Colors.red,),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                );
              }
              return Container();
            })

// This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
