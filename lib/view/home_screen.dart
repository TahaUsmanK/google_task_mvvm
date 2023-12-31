import 'package:flutter/material.dart';
import 'package:google_task_mvvm/view/my_task_screen.dart';
import 'package:google_task_mvvm/view/new_list_screen.dart';
import 'package:google_task_mvvm/view/starred_task_screen.dart';
import 'package:google_task_mvvm/view/widgets/bottom_navigation_bar.dart';
import 'package:google_task_mvvm/view_model/auth_view_model.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenContent createState() => _HomeScreenContent();
}

class _HomeScreenContent extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 25, 25),
          title: const Text(
            'Tasks',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: authViewModel.user != null
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage(authViewModel.user!.photoURL!),
                    )
                  : InkWell(
                      onTap: () async {
                        await authViewModel.signInWithGoogle();
                      },
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.blue.shade200,
            indicatorWeight: 4.0,
            dividerColor: Colors.transparent,
            labelColor: Colors.blue.shade200,
            labelPadding: EdgeInsets.only(right: 26),
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.only(right: 65),
            isScrollable: false,
            tabs: [
              Tab(icon: Icon(Icons.star)),
              Tab(text: 'My tasks'),
              Tab(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NewListScreen()),
                    );
                  },
                  child: Row(
                    children: [Icon(Icons.add), Text('New list')],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StarredTaskScreen(),
            MyTasksScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          currentIndex: homeViewModel.currentIndex,
          onTap: (index) {
            homeViewModel.setIndex(index);
          },
        ),
      ),
    );
  }
}
