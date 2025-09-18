import 'package:flutter/cupertino.dart';
import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:learn_loop/services/getUserID.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier{

  final Map<String,bool> _isDark={};

   bool? getIsDark(String userID)=>_isDark[userID];

   ThemeProvider(){
     _init();
   }

   Future<void> _init() async{
     final id=await Securestorage.getUserID();
     if(id!=null){
       loadTheme(userID: id);
     }
   }


   Future<void> loadTheme({required String userID}) async{
     final theme=await Securestorage.getThemeMode(userID);
     if(theme!=null){
       if(theme=='Dark'){
         _isDark[userID]=true;
       }
       else{
         _isDark[userID]=false;
       }
       notifyListeners();
     }
   }

   Future<void> toggleTheme(bool value) async{
     final id=await Securestorage.getUserID();
     _isDark[id!]=value;
     await Securestorage.saveThemeMode(id,value?'Dark':'Light');
     notifyListeners();

   }



}
