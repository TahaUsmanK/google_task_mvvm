import 'package:flutter/material.dart';
import 'package:google_task_mvvm/model/task.dart';
import 'package:google_task_mvvm/view/widgets/task_tile.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class StarredTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return FutureBuilder<List<Task>>(
      future: homeViewModel.starredTasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return RefreshProgressIndicator();
        } else if (snapshot.hasError) {
          return _buildErrorState(snapshot.error.toString());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final starredTasks = snapshot.data!;

          return _buildTasksList(context, starredTasks);
        } else {
          return _buildNoStarredTasksState();
        }
      },
    );
  }

  Widget _buildTasksList(BuildContext context, List<Task> tasks) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Container(
      color: Color.fromARGB(255, 26, 25, 25),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onStarToggle: (taskId) {
              homeViewModel.toggleStar(taskId, context);
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

  Widget _buildNoStarredTasksState() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 25, 25),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/starred_task.png', scale: 2.5),
            Text(
              'No starred tasks',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 16),
              child: Text(
                'Mark important tasks with a star to easily find them here',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
