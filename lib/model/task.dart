import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;

  Task({
    required this.id,
    required this.title,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Task{id: $id, task: $title,}';
  }
}
