import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mooseetws/data/MooseList.dart';
import 'package:mooseetws/services/storageservice.dart';


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

  postMyInfo(String token, String vehicleNumber) async {
    String url = "https://mooseetws.herokuapp.com/api/mobile/v1";
    MyInfo myInfo = MyInfo(licensePlate: "1234", registrationID: token);
    String ret = jsonEncode(myInfo);
    http.Response response = await client.post(url, body: ret);
    print("****** response " + response.statusCode.toString());
    StorageService().storeFCMToken(token);
  }
}

class MyInfo {
  String licensePlate;
  String registrationID;

  MyInfo({this.licensePlate, this.registrationID});

  Map<String, dynamic> toJson() => {
    "licensePlate": licensePlate,
    "registrationID": registrationID,
  };
}