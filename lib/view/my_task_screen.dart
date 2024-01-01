import 'package:flutter/material.dart';
import 'package:google_task_mvvm/model/task.dart';
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
          print(snapshot.data);
          return _buildTasksList(context, snapshot.data!);
        } else {
          return _buildNoTasksState();
        }
      },
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

  Widget _buildTasksList(BuildContext context, List<Task> tasks) {
    return Container(
      color: Color.fromARGB(255, 26, 25, 25),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 3,
            color: Colors.white,
            child: ListTile(
              title: Text(
                tasks[index].title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              trailing: Icon(Icons.star_border_outlined),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoTasksState() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 25, 25),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/task.png', scale: 12),
            Text(
              'No tasks yet',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Add your to-dos and keep track of them across Google Workspace',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
