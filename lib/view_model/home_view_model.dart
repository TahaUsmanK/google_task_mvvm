import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_task_mvvm/model/task.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('lists');

  Stream<List<Task>> get tasksStream =>
      _tasksCollection.snapshots().map((snapshot) {
        final tasks =
            snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
        print(tasks);
        return tasks;
      });
}
