import 'package:flutter/material.dart';
import 'package:google_task_mvvm/model/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final void Function(String) onStarToggle;

  TaskTile({
    required this.task,
    required this.onStarToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio(
        value: task.id,
        groupValue: 'selectedTaskId',
        toggleable: true,
        fillColor: MaterialStateProperty.all(Colors.white),
        onChanged: (value) {
          onStarToggle(task.id);
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
      ),
      trailing: InkWell(
        child: Icon(
          Icons.star_border_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
