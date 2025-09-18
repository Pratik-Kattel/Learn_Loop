import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:provider/provider.dart';
import 'package:learn_loop/services/Name_Provider.dart';


class FetchUserData{
  static Future<String?> fetchFullName(BuildContext context) async {
    final token = await Securestorage.getToken();
    if (token == null) {
      return null;
    }
    final url = Uri.parse('http://10.0.2.2:3000/api/auth/get-fullname');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        context.read<NameProvider>().updateName(fullName: data['fullname'].toString());
      } else {
        print('Failed to get the initials');
      }
    } catch (e) {
      print('Error caught: $e');
    }
    return null;
  }


  static Future<String?> fetchemail(BuildContext context) async {
    final token = await Securestorage.getToken();
    if (token == null) {
      return null;
    }
    final url = Uri.parse('http://10.0.2.2:3000/api/auth/get-email');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final email = jsonDecode(response.body);
        context.read<NameProvider>().updateName(email: email['email']['email'].toString());
      }
    } catch (e) {
      print('Error in mail fetching $e');
    }
    return null;
  }

  static Future<String?> fetchBio(BuildContext context) async{
    final token=await Securestorage.getToken();
    if(token==null){
      return null;
    }
    final url=Uri.parse('http://10.0.2.2:3000/api/auth/get-bio');
    try {
      final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final Bio = jsonDecode(response.body);
        context.read<NameProvider>().updateName(bio: Bio['bio']['bio'].toString());
      }
    }
    catch(e){
      print('Error occurred: $e');
    }
    return null;
  }

  static Future<String?> fetchfirstName(BuildContext context) async{
    final token=await Securestorage.getToken();
    if(token==null){
      return null;
    }
    final url=Uri.parse('http://10.0.2.2:3000/api/auth/get-firstname');
    try {
      final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final firstname = jsonDecode(response.body);
        context.read<NameProvider>().updateName(firstName: firstname ['firstname']['first_name'].toString());
      }
    }
    catch(e){
      print('Error occurred: $e');
    }
    return null;
  }

  static Future<String?> fetchlastName(BuildContext context) async{
    final token=await Securestorage.getToken();
    if(token==null){
      return null;
    }
    final url=Uri.parse('http://10.0.2.2:3000/api/auth/get-lastname');
    try {
      final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      if (response.statusCode == 200) {
        final lastname = jsonDecode(response.body);
        context.read<NameProvider>().updateName(lastName: lastname ['lastname']['last_name'].toString());
      }
    }
    catch(e){
      print('Error occurred: $e');
    }
    return null;
  }

 static Future<String?> fetchInitial( BuildContext context) async {
    final token = await Securestorage.getToken();
    print('Token retrieved in fetchInitial: $token');
    if (token == null) {
      print('No token found');
      return null;
    }
    final url = Uri.parse('http://10.0.2.2:3000/api/auth/get-initial');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userID=await Securestorage.getUserID();
        context.read<UpdateAvatar>().updateAvatar(initial: data['initial'].toString(), userID: userID);
       return data['initial'];
      } else {
        print('Failed to get the initial ${response.statusCode}');
      }
    } catch (e) {
      print('Error catched ${e.toString()}');
    }
  }
  }


