import 'dart:convert';
import 'dart:developer';
import 'package:akzonobel/login/model/user_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  LocalStorage._(this.secureStorage);

  // final SharedPreferences prefs;
  final FlutterSecureStorage secureStorage;

  static LocalStorage? _instance;
  static LocalStorage get shared => _instance!;

  static Future<void> initialize() async {
    const secureStorage = FlutterSecureStorage();
    _instance = LocalStorage._(secureStorage);
  }

  static const String kUserKey = 'token';

  Future<void> saveUserData(UserData? userData) async {
    if (userData == null) return;

    log('Login Data: ${userData.toJson()}');
    final userString = jsonEncode(userData.toJson());

    await secureStorage.write(key: kUserKey, value: userString);
    log('User data saved successfully');
  }

  Future<UserData?> getUserData() async {
    final jsonString = await secureStorage.read(key: kUserKey);

    if (jsonString == null) {
      return null;
    }

    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserData.fromJson(jsonMap);
  }


  Future<bool> isLoggedIn() async {
    return (await getUserData()) != null;
  }

  Future<String> getUserToken() async {
    final userData = await getUserData();
    return userData?.token ?? '';
  }
}
