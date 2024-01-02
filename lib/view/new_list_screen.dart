import 'package:flutter/material.dart';
import 'package:google_task_mvvm/view/home_screen.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class NewListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return ChangeNotifierProvider(
      create: (context) => homeViewModel,
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
                    homeViewModel.addNewTab();
                    homeViewModel.taskcontroller.clear();
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
            'Create new list',
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
                  controller: homeViewModel.taskcontroller,
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
