import 'package:flutter/material.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class MyTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

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
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Add your to-dos and keep track of them across Google Workspace',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
