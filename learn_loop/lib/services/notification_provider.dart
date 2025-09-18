import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier{
  int notification=0;

  void notificationIncrease(){
    notification++;
    notifyListeners();
  }

  void clearNotification(){
    notification=0;
    notifyListeners();
  }
}