import 'dart:convert';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:get_storage/get_storage.dart';

class Database {
  static Future getBalance(FirebaseDatabase databaseRef, String email) async {
    // late double balance;
    email = email.replaceAll(".", "_");
    var data;
    await databaseRef.ref().child("Users/$email").get().then(
      (snapshot) {
        if (snapshot.exists) {
          Map user = snapshot.value as Map;
          data = user;
          return data;
        }
        // else {
        //   databaseRef.ref(email.replaceAll(".", "_")).set(0);
        //   balance = 0;
        // }
      },
    ).catchError((error) {
      throw error;
    });
    return data;
    // return balance;
  }

  static Future getCommunity(FirebaseDatabase databaseRef) async {
    var data;
    await databaseRef.ref().child("Community").get().then(
      (snapshot) {
        if (snapshot.exists) {
          print(snapshot.value);
          Map user = snapshot.value as Map;
          data = user;
          return data;
        }
      },
    ).catchError((error) {
      throw error;
    });
    return data;
  }

  static void setData(FirebaseDatabase databaseRef, String email, String name,
      String img) async {
    final db = databaseRef.ref('Users').child(email.replaceAll(".", "_"));

    Map data = {"name": name, "img": img, "level": 0, "progress": 0};

    await db.set(data);
  }

  static void createPost(
      FirebaseDatabase databaseRef, String img, String desc) async {
    final db = databaseRef
        .ref('Community')
        .child('/P${Random().nextInt(1000).toString()}');
    Map data = {
      "desc": desc,
      "img": img,
      "likes": 0,
      "timestamp": DateTime.now().toString(),
      "user": GetStorage().read("email")
    };

    await db.set(data);
  }
}
