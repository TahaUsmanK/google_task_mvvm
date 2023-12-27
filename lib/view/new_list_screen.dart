import 'package:flutter/material.dart';
import 'package:google_task_mvvm/view/home_screen.dart';

class NewListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Divider(
                color: Color.fromARGB(255, 70, 70, 70),
                height: 10,
                thickness: 1,
              ),
            ),
          ),
          Container(
            color: Color.fromARGB(255, 26, 25, 25),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '   Enter list title',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
