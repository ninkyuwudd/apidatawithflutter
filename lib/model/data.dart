import 'dart:convert';
import 'package:apiwithflutter/model/datamodel.dart';
import 'package:http/http.dart' as http;

class Datatest{
  Future<Datamodel>? getdatamodel() async{
    var endpoint = Uri.parse("http://192.168.32.242:3300/users");
    var response = await http.get(endpoint);
    print(response.body);
    var body = jsonDecode(response.body);
    return Datamodel.fromJson(body);
  }

}