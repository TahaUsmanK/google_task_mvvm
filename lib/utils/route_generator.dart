import 'package:flutter/material.dart';
import 'package:google_task_mvvm/view/home_screen.dart';
import 'package:google_task_mvvm/view/my_task_screen.dart';
import 'package:google_task_mvvm/view/new_list_screen.dart';
import 'package:google_task_mvvm/view/starred_task_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/my_tasks':
        return MaterialPageRoute(builder: (_) => MyTasksScreen());
      case '/new_list':
        return MaterialPageRoute(builder: (_) => NewListScreen());
      case '/starred_tasks':
        return MaterialPageRoute(builder: (_) => StarredTaskScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
