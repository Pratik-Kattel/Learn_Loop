import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_loop/services/flutter_secure_storage_service.dart';

class AuthServices {
  static const String baseURL = 'http://10.0.2.2:3000/api/auth';

  static Future<http.Response> sendOTP({
    required String first_name,
    required String last_name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    showDialog(context: context,barrierDismissible: false, builder: (BuildContext context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(padding: EdgeInsetsGeometry.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text('Sending OTP...')
            ],
          ),
        )
        
      );
    });
    
    
    final url = Uri.parse('$baseURL/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'first_name': first_name,
          'last_name': last_name,
          'email': email,
          'password': password,
        }),
      );
      return response;
    } catch (e) {
      print('Error in sending OTP:${e}');
      rethrow;
    }
  }

  static Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseURL/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final id=responseData['id'];
        await Securestorage.saveToken(token);
        await Securestorage.saveUserID(id);
      }
      return response;
    } catch (e) {
      print('Error ${e}');
      rethrow;
    }
  }
}
