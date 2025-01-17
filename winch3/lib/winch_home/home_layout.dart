import 'package:carwinch/color_controller.dart';
import 'package:flutter/material.dart';


import 'acc_screen/account_screen.dart';
import 'servicepage.dart';
import 'historypage.dart';
import 'homepage.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  List<Widget> screens = [
    Homepage(),
    ServicePage(),
    Historypage(),
    AccountScreen(email: ''),
  ];

  List<String> titles = [
    'Home',
    'Service',
    'History',
    'Account',
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [

          screens[currentIndex],

          if (currentIndex == 0)
            Text(''),


        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorController.primaryDarkMode,
        selectedItemColor: ColorController.orange,
        unselectedItemColor: ColorController.primaryLiteMode,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }

}
