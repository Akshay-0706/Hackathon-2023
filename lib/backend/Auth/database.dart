import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

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

  static void setData(FirebaseDatabase databaseRef, String email, String name,
      String img) async {
    final db = databaseRef.ref('Users').child(email.replaceAll(".", "_"));

    Map data = {"name": name, "img": img, "level": 0, "progress": 0};

    await db.set(data);
    // await databaseRef
    //     .ref(email.replaceAll(".", "_"))
    //     .set(email)
    //     .then(
    //       (snapshot) {},
    //     )
    //     .catchError((error) => throw error);
  }
}
