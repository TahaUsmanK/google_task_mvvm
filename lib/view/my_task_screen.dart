import 'package:flutter/material.dart';
import 'package:google_task_mvvm/model/task.dart';
import 'package:google_task_mvvm/view/no_task_screen.dart';
import 'package:google_task_mvvm/view/widgets/task_tile.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class MyTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return StreamBuilder<List<Task>>(
      stream: viewModel.tasksStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final tasks = snapshot.data!;

          return _buildTasksList(context, tasks, viewModel);
        } else {
          return NoTasksScreen();
        }
      },
    );
  }

  Widget _buildTasksList(
      BuildContext context, List<Task> tasks, HomeViewModel viewModel) {
    return Container(
      color: Color.fromARGB(255, 26, 25, 25),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onStarToggle: (taskId) {
              viewModel.toggleStar(taskId, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Container(
      color: Color.fromARGB(255, 26, 25, 25),
      child: Center(
        child: Text(
          'Error: $error',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
