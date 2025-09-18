import 'package:flutter/cupertino.dart';

class NameProvider extends ChangeNotifier{
  String?_firstName;
  String?_lastName;
  String?_bio;
  String?_fullName;
  String?_email;

  String? get firstName=>_firstName;
  String? get lastName=>_lastName;
  String? get bio=>_bio;
  String? get fullName=>_fullName;
  String? get email=>_email;


  void updateName({String?firstName,String?lastName,String?bio,String?fullName,String?email}){
    bool changed=false;
    if(firstName!=null&&firstName!=_firstName){
      _firstName=firstName;
      changed=true;
    }
    if(lastName!=null&&lastName!=_lastName){
      _lastName=lastName;
      changed=true;
    }
    if(bio!=null&&bio!=_bio){
      _bio=bio;
      changed=true;
    }
    if(fullName!=null&&fullName!=_fullName){
      _fullName=fullName;
      changed=true;
    }
    if(email!=null && email!=_email){
      _email=email;
      changed=true;
    }
    if(changed){
      notifyListeners();
    }
  }


}