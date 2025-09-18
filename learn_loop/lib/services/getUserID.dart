import 'package:flutter/widgets.dart';
import 'package:learn_loop/services/flutter_secure_storage_service.dart';

class UserID extends ChangeNotifier{
  String? _userID;

  String? get userID=>_userID;

  Future<void> getUserID() async{
    _userID=await Securestorage.getUserID();
    notifyListeners();
  }

}