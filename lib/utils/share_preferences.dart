import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static SharedPreferencesHelper? instance;

  factory SharedPreferencesHelper() => instance ??= SharedPreferencesHelper._();

  late SharedPreferences prefs;

  static const isLoggedInKey = 'isLoggedInKey';
  static const userKey = 'userKey';

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool getIsLoggedIn() {
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  User? getUser() {
    final rawUser = prefs.getString(userKey) ?? '';
    if (rawUser.isNotEmpty) {
      final decodedUser = jsonDecode(rawUser) as User;
      return decodedUser;
    }
    return null;
  }

  Future<bool> setUser(User user) async {
    final jsonUser = jsonEncode(user);
    return await prefs.setString(userKey, jsonUser);
  }

  Future<void> setIsLoggedIn(bool status) {
    return prefs.setBool(isLoggedInKey, status);
  }
}
