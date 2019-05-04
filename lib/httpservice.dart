import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mooseetws/data/MooseList.dart';


class BackendClient {
  static final BackendClient _singleton = new BackendClient._internal();
  http.Client client = new http.Client();

  factory BackendClient() {
    return _singleton;
  }

  BackendClient._internal();

  String token;


  setToken(String token) {
    this.token = token;
  }

  Future<List<MooseLocation>> getMooseList() async {
    String url = "https://mooseetws.herokuapp.com/api/mobile/v1";
    http.Response response = await client.get(url);
    final jsonResponse = json.decode(response.body);
    MooseLocationsList mooseLocationsList = MooseLocationsList.fromJson(jsonResponse);
    return mooseLocationsList.mooseLocations;
  }
}