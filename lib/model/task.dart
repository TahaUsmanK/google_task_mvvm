class Task {
  final String title;

  Task({required this.title});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
    );
  }
}
