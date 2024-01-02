import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_task_mvvm/view/new_list_screen.dart';
import 'package:google_task_mvvm/view/my_task_screen.dart';
import 'package:google_task_mvvm/view/starred_task_screen.dart';
import 'package:google_task_mvvm/view/widgets/bottom_navigation_bar.dart';
import 'package:google_task_mvvm/view_model/auth_view_model.dart';
import 'package:google_task_mvvm/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

      homeViewModel.tabs = [
        Tab(icon: Icon(Icons.star)),
        Tab(text: 'My tasks'),
        Tab(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NewListScreen()));
            },
            child: Row(
              children: [Icon(Icons.add), Text('New list')],
            ),
          ),
        ),
      ];

      homeViewModel.tabViews = [
        StarredTaskScreen(),
        MyTasksScreen(),
        Scaffold(
          backgroundColor: Color.fromARGB(255, 26, 25, 25),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return DefaultTabController(
      length: homeViewModel.tabs.length,
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
            indicatorWeight: 3.0,
            dividerColor: Colors.transparent,
            labelColor: Colors.blue.shade200,
            labelPadding: EdgeInsets.only(right: 26),
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.only(right: 65),
            isScrollable: true,
            tabs: homeViewModel.tabs,
          ),
        ),
        body: TabBarView(
          children: homeViewModel.tabViews,
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
