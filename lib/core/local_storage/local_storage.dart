import 'dart:convert';
import 'dart:developer';
import 'package:akzonobel/login/model/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._(this.prefs);

  final SharedPreferences prefs;

  static LocalStorage? _instance;
  static LocalStorage get shared => _instance!;

  static Future<void> initialize() async {
    _instance = LocalStorage._(await SharedPreferences.getInstance());
  }

  static const String kUserKey = 'token';

  Future<void> saveUserData(UserData? userData) async {
    if (userData == null) return;

    log('Login Data: ${userData.toJson()}');
    final userString = jsonEncode(userData.toJson());

    await prefs.setString(kUserKey, userString);
    log('User data saved successfully');
  }

  UserData? getUserData() {
    final jsonString = prefs.getString(kUserKey);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserData.fromJson(jsonMap);
  }

  bool get isLoggedIn => getUserData() != null;

  String getUserToken() {
    final userData = getUserData();
    return userData?.token ?? '';
  }
}
