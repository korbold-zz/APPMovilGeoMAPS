import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeEvent with ChangeNotifier {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void initNotificationsPemision() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((value) {
      print('========TOKEN=======');
      print(value);
    });
    //fcpXPxXxREmuH7NDugHx-Y:APA91bFfvXs8lHsA0_tucUtBkWMHjyClzM4nTi4634w6Ae7Ry0Kyo6FI81MfJ75G1yn2naW2jHo8p2JxN86_Bj3zcDZkQxnaCokd5nsDVgFBWduMD9Gzv5xbdV4QyIuVXYcW87KgDyVe
    _firebaseMessaging.configure(
      onMessage: (information){
        print('========= onMessage =========');
        print(information);
      },
      onResume: (information){
        print('========= onResume =========');
        print(information);
      },
      onLaunch: (information){
        print('========= onLaunch =========');
        print(information);
      },
    );
  }
  
  
}

