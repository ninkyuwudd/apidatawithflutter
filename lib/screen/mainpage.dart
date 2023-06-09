import 'package:apiwithflutter/model/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
    TextEditingController nama = TextEditingController();
    TextEditingController asal = TextEditingController();
    TextEditingController tujuan = TextEditingController();
    TextEditingController kelas = TextEditingController();
    TextEditingController berangkat = TextEditingController();
    TextEditingController pulang = TextEditingController();
    TextEditingController harga = TextEditingController();

    Future<List<dynamic>> _getdatauser() async {
      var endpoint = Uri.parse("${Apilink.BASE_URL}/pesawat");
      var response = await http.get(endpoint);
      print(response.body);
      // var body = jsonDecode(response.body);
      return json.decode(response.body);
    }

    Future<List<dynamic>> _deletedatauser(int number) async {
      print(number);
      var endpoint = Uri.parse("${Apilink.BASE_URL}/pesawat/delete/$number");
      var response = await http.delete(endpoint);
      // var body = jsonDecode(response.body);
      return json.decode(response.body);
    }

    Future<Datamodel> _editdatauser(
        int number,
        String namapesawat,
        String asal,
        String tujuan,
        String kelas,
        String tanggalberangkat,
        String tanggalpulang,
        String harga
        ) async {
      var endpoint = Uri.parse("${Apilink.BASE_URL}/pesawat/update/$number");
      var response = await http.put(endpoint, body: {
        "namapesawat": namapesawat,
        "asal": asal,
        "tujuan": tujuan,
        "kelas": kelas,
        "tanggalberangkat": tanggalberangkat,
        "tanggalpulang": tanggalpulang,
        "harga": harga
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
        String namapesawat,
        String asal,
        String tujuan,
        String kelas,
        String tanggalberangkat,
        String tanggalpulang,
        String harga
        ) async {
      final endpoint = Uri.parse("${Apilink.BASE_URL}/pesawat/register");
      final response = await http.post(endpoint, body: {
        "namapesawat": namapesawat,
        "asal": asal,
        "tujuan": tujuan,
        "kelas": kelas,
        "tanggalberangkat": tanggalberangkat,
        "tanggalpulang": tanggalpulang,
        "harga": harga
      });
      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return Datamodel.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to create tiket');
      }
    }

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Add Data"),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: nama,
                                      decoration: InputDecoration(
                                          hintText: "nama pesawat"),
                                    ),
                                    TextField(
                                      controller: asal,
                                      decoration:
                                          InputDecoration(hintText: "asal"),
                                    ),
                                    TextField(
                                      controller: tujuan,
                                      decoration:
                                          InputDecoration(hintText: "tujuan"),
                                    ),
                                    TextField(
                                      controller: kelas,
                                      decoration:
                                          InputDecoration(hintText: "kelas"),
                                    ),
                                    TextField(
                                      controller: berangkat,
                                      decoration: InputDecoration(
                                          hintText: "tanggal berangkat"),
                                    ),
                                    TextField(
                                      controller: pulang,
                                      decoration: InputDecoration(
                                          hintText: "tanggal pulang"),
                                    ),
                                    TextField(
                                      controller: harga,
                                      keyboardType: TextInputType.number,
                                      decoration:
                                          InputDecoration(hintText: "harga"),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      final getnama = nama.text;
                                      final getasal = asal.text;
                                      final gettujuan = tujuan.text;
                                      final getkelas = kelas.text;
                                      final getberangkat = berangkat.text;
                                      final getpulang = pulang.text;
                                      final getharga = harga.text;
                                      adddatauser(
                                          getnama,
                                          getasal,
                                          gettujuan,
                                          getkelas,
                                          getberangkat,
                                          getpulang,
                                          getharga);
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
                    // height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.all(10),

                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                      '${snapshot.data[index]["namapesawat"]} ${snapshot.data[index]["asal"]}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Berangkat  : ${DateFormat.yMMMd().format(DateTime.parse(snapshot.data[index]["tanggalberangkat"]))}'),
                                      Text(
                                          'Pulang: ${DateFormat.yMMMd().format(DateTime.parse(snapshot.data[index]["tanggalpulang"]))}'),
                                    ],
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                          'Rp. ${snapshot.data[index]["harga"]}')
                                    ],
                                  ),
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
                                                  content: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                  
                                                          controller: nama,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "nama pesawat"),
                                                        ),
                                                        TextFormField(
                                                  
                                                          controller: asal,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "asal"),
                                                        ),
                                                        TextFormField(
                                                  
                                                          controller: tujuan,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "tujuan"),
                                                        ),
                                                        TextFormField(
                                                  
                                                          controller: kelas,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "kelas"),
                                                        ),
                                                        TextFormField(
                                                          
                                                          controller: berangkat,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "tanggal berangkat"),
                                                        ),
                                                        TextFormField(
                                                          
                                                          controller: pulang,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "tanggal pulang"),
                                                        ),
                                                        TextFormField(
                                                  
                                                          controller: harga,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "harga"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          final getnama =
                                                              nama.text;
                                                          final getasal =
                                                              asal.text;
                                                          final gettujuan =
                                                              tujuan.text;
                                                          final getkelas =
                                                              kelas.text;
                                                          final getberangkat =
                                                              berangkat.text;
                                                          final getpulang =
                                                              pulang.text;
                                                          final getharga =
                                                              harga.text;
                                                          _editdatauser(
                                                              snapshot.data[
                                                                  index]['id'],
                                                              getnama,
                                                              getasal,
                                                              gettujuan,
                                                              getkelas,
                                                              
                                                                  getberangkat,
                                                              
                                                                  getpulang,
                                                              
                                                                  getharga);
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
          ),
    );
  }
}
