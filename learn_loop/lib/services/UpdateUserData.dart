import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpdateUserData{
  static Future<String?> updateData({
    required BuildContext context,
    required TextEditingController firstname,
    required TextEditingController lastname,
    required TextEditingController bio,
}) async {
    final url = Uri.parse('http://10.0.2.2:3000/api/auth/update-info');
    try {
      final token= await Securestorage.getToken();
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json','Authorization':'Bearer $token'},
        body: jsonEncode({
          'first_name': firstname.text.trim(),
          'last_name': lastname.text.trim(),
          'bio': bio.text,
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
        final message = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message['message'])));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Internal error occurred')));
    }
  }
}