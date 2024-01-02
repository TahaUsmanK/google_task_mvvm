import 'package:flutter/material.dart';
import 'package:google_task_mvvm/view/home_screen.dart';
import 'package:google_task_mvvm/view_model/new_list_view_model.dart';
import 'package:provider/provider.dart';

class NewTaskScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewListViewModel(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 25, 25),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 25, 25),
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Icon(
              Icons.cancel,
              color: Colors.white,
            ),
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: InkWell(
                  onTap: () {
                    Provider.of<NewListViewModel>(context, listen: false)
                        .saveList(_titleController.text.trim());
                    _titleController.clear();
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Text(
            'Create new task',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                color: Color.fromARGB(255, 26, 25, 25),
                child: TextField(
                  controller: _titleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter task',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
