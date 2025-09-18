import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Securestorage {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  static Future<void> saveUserID(String id) async {
    await _storage.write(key: 'id', value: id);
  }

  static Future<String?> getUserID() async {
    return await _storage.read(key: 'id');
  }

  static Future<void> deleteID() async {
    await _storage.delete(key: 'id');
  }

  static Future<void> saveImageUrl(String userID, String url) async {
    await _storage.write(key: 'photo_$userID', value: url);
  }

  static Future<void> deleteImageUrl(String userID) async {
    await _storage.delete(key: 'photo_$userID');
  }

  static Future<String?> getImageUrl(String userID) async {
    return await _storage.read(key: 'photo_$userID');
  }

  static Future<void> saveThemeMode(String userID,String mode) async {
    await _storage.write(key: '$userID themeMode', value: mode);
  }

  static Future<String?> getThemeMode(String userID) async {
    return await _storage.read(key: '$userID themeMode');
  }

  static Future<void> deleteThemeMode(String userID) async {
    await _storage.delete(key: '$userID themeMode');
  }
}
