import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/data.dart';
import '../model/datamodel.dart';

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
    final idnya = TextEditingController();
    final fsname = TextEditingController();
    final lsname = TextEditingController();
    final phonenum = TextEditingController();

    Future<List<dynamic>> _getdatauser() async {
      var endpoint = Uri.parse("http://192.168.32.242:3300/users");
      var response = await http.get(endpoint);
      print(response.body);
      // var body = jsonDecode(response.body);
      return json.decode(response.body);
    }

    Future<List<dynamic>> _deletedatauser(String? number) async {
      print(number);
      var endpoint = Uri.parse("http://192.168.32.242:3300/users/'$number'");
      var response = await http.delete(endpoint);
      // var body = jsonDecode(response.body);
      return json.decode(response.body);
    }

    Future<Datamodel> _editdatauser(
        String number, String firstname, String lastname, String phone) async {
      var endpoint = Uri.parse("http://192.168.32.242:3300/users/'$number'");
      var response = await http.put(endpoint, body: {
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'id': number
      });
      // var body = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        // Resource updated successfully
        print('Resource updated');
      } else {
        // There was an error updating the resource
        print('Error updating resource: ${response.statusCode}');
      }
      return json.decode(response.body);
    }

    Future<Datamodel> adddatauser(
        String number, String firstname, String lastname, String phone) async {
      final endpoint = Uri.parse("http://192.168.32.242:3300/users");
      final response = await http.post(endpoint, body: {
        'id': number,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone
      });
      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return Datamodel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create album.');
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Add Data"),
                            content: Column(
                              children: [
                                TextField(
                                  controller: idnya,
                                  decoration: InputDecoration(hintText: "id"),
                                ),
                                TextField(
                                  controller: fsname,
                                  decoration: InputDecoration(
                                      hintText: "New firstname"),
                                ),
                                TextField(
                                  controller: lsname,
                                  decoration:
                                      InputDecoration(hintText: "New lastname"),
                                ),
                                TextField(
                                  controller: phonenum,
                                  decoration:
                                      InputDecoration(hintText: "New phone"),
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    final thisid = idnya.text;
                                    final fsnamedata = fsname.text;
                                    final lsnamedata = lsname.text;
                                    final phonedata = phonenum.text;
                                    adddatauser(thisid, fsnamedata, lsnamedata,
                                        phonedata);
                                    setState(() {});
                                  },
                                  child: Text("Submit"))
                            ],
                          ));
                  setState(() {});
                },
                icon: Icon(Icons.add))
          ],
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
                                      // _deletedatauser(snapshot.data[index]['id']
                                      //     .toString());
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text("Edit Data"),
                                                content: Column(
                                                  children: [
                                                    TextField(
                                                      controller: fsname,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "New firstname"),
                                                    ),
                                                    TextField(
                                                      controller: lsname,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "New lastname"),
                                                    ),
                                                    TextField(
                                                      controller: phonenum,
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  "New phone"),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        var fsnamedata =
                                                            fsname.text;
                                                        var lsnamedata =
                                                            lsname.text;
                                                        var phonedata =
                                                            phonenum.text;
                                                        _editdatauser(
                                                            snapshot.data[index]
                                                                ['id'],
                                                            fsnamedata,
                                                            lsnamedata,
                                                            phonedata);
                                                        setState(() {});
                                                      },
                                                      child: Text("Update"))
                                                ],
                                              ));
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deletedatauser(
                                          snapshot.data[index]['id']);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
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
