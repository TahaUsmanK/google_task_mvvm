import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_task_mvvm/utils/route_generator.dart';
import 'package:google_task_mvvm/view/home_screen.dart';
import 'package:google_task_mvvm/view_model/auth_view_model.dart';
import 'package:google_task_mvvm/view_model/new_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewListViewModel(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
