import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_task_mvvm/model/task.dart';
import 'package:google_task_mvvm/view/no_task_screen.dart';
import 'package:google_task_mvvm/view/starred_task_screen.dart';

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

  Future<void> toggleStar(String taskId, BuildContext context) async {
    try {
      final taskDoc = await _tasksCollection.doc(taskId).get();
      if (taskDoc.exists) {
        final Map<String, dynamic>? data =
            taskDoc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('starred')) {
          final bool isStarred = data['starred'] ?? false;
          await _tasksCollection.doc(taskId).update({'starred': !isStarred});

          if (!isStarred) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StarredTaskScreen()),
            );
          }
        } else {
          print('Field "starred" does not exist in the document.');
        }
      } else {
        print('Task with id $taskId not found.');
      }
    } catch (e) {
      print('Error toggling star: $e');
      throw e;
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
