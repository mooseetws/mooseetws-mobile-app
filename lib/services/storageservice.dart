import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class StorageService {
  static final StorageService _singleton = new StorageService._internal();
  factory StorageService() {
    return _singleton;
  }

  StorageService._internal();

  storeFCMToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
  }

  Future<String> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }
}