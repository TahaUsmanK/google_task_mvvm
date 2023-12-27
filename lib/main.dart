import 'package:flutter/material.dart';
import 'package:google_task_mvvm/utils/route_generator.dart';
import 'package:google_task_mvvm/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
