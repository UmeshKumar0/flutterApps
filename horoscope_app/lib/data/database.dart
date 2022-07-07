// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profile =
      FirebaseFirestore.instance.collection("profileInfo");

  Future<void> createData(String email, String sign) async {
    return await profile.doc(email).set({
      'email': email,
      'sign': sign,
    });
  }

  Future getData() async {
    List itemList = [];
    try {
      await profile.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemList.add(element.data);
          print("ItemList${itemList[0]}");
        }
      });
    } catch (e) {
      print("Error in getData$e");
      return null;
    }
  }
}
