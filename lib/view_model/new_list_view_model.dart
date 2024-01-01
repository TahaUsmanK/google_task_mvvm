import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewListViewModel extends ChangeNotifier {
  final CollectionReference _listsCollection =
      FirebaseFirestore.instance.collection('lists');

  Future<void> saveList(String title) async {
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        print("User not authenticated");
        return;
      }

      await _listsCollection.add(
          {'title': title, 'userId': FirebaseAuth.instance.currentUser!.uid});

      notifyListeners();
    } catch (e) {
      print('Error saving list: $e');
      throw e;
    }
  }
}
