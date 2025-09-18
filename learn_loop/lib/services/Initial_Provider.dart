

import 'package:flutter/widgets.dart';

class UpdateAvatar extends ChangeNotifier{
  final Map<String,String> _userPhotos={};
  final Map<String,String> _userInitials={};


  String? getPhotoUrl(String userID)=>_userPhotos[userID];
  String? getInitial(String userID)=>_userInitials[userID];

  void updateAvatar({ required userID,String? photo,String?initial}){
    bool changed=false;
    if(photo!=null && photo!=_userPhotos[userID]){
      _userPhotos[userID]=photo;
      changed=true;
    }

    if(initial!=null && initial!=_userInitials[userID]){
      _userInitials[userID]=initial;
      changed=true;
    }

    if(changed){
      notifyListeners();
    }

  }

}