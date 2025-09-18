import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:provider/provider.dart';

class UploadProfilePicture{
  static Future<String?> Upload(File imageFile, BuildContext context) async{
    final token=await Securestorage.getToken();
    if(token==null){
      return null;
    }
    var request=http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:3000/api/auth/change-profile-picture'));
    request.headers['Authorization']='Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));

    var response=await request.send();
    if(response.statusCode==200){
      final resBody=await response.stream.bytesToString();
      final decoded=jsonDecode(resBody);
      final newurl=decoded['photo'];
      final userID=await Securestorage.getUserID();
      await Securestorage.saveImageUrl(userID!,newurl);
      context.read<UpdateAvatar>().updateAvatar(photo: newurl, userID: userID);
      return newurl;
    }
    else{
      return null;
    }

  }
}