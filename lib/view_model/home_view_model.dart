import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_task_mvvm/model/task.dart';
import 'package:google_task_mvvm/view/no_task_screen.dart';

class HomeViewModel extends ChangeNotifier {
  late List<Tab> tabs;
  late List<Widget> tabViews;
  TextEditingController taskcontroller = TextEditingController();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('lists');

  HomeViewModel() {
    tabs = [];
    tabViews = [];
    loadTabsFromFirestore();
  }

  void loadTabsFromFirestore() {
    FirebaseFirestore.instance
        .collection('tabs')
        .snapshots()
        .listen((snapshot) {
      tabs = snapshot.docs.map((doc) => Tab(text: doc['title'])).toList();
      tabViews = tabs.map((tab) => NoTasksScreen()).toList();
      notifyListeners();
    });
  }

  void saveTabsToFirestore() {
    for (int i = 0; i < tabs.length; i++) {
      FirebaseFirestore.instance
          .collection('tabs')
          .add({'title': tabs[i].text});
    }
  }

  Stream<List<Task>> get tasksStream =>
      _tasksCollection.snapshots().map((snapshot) {
        final tasks =
            snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
        return tasks;
      });

  Future<List<Task>> get starredTasks async {
    final tasks = await tasksStream.first;
    return tasks.where((task) => task.starred).toList();
  }

  void addNewTab() {
    tabs.add(Tab(text: taskcontroller.text.trim()));
    tabViews.add(NoTasksScreen());
    saveTabsToFirestore();
    notifyListeners();
  }
}
