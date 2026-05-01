import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/screens/complete_tasks_screen.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    TasksScreen(),
    CompleteTasksScreen(),
    ProfileScreen(),
  ];
  int _currentindex = 0;

  /// curentindex = 0 ;Widget _currentScreen = HomeScreen()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF181818),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int? index) {
          setState(() {
            _currentindex = index ?? 0;
          });
        },
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Home.svg", 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Icon (1).svg", 1),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Icon (2).svg", 2),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture("assets/images/Icon (3).svg", 3),
            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(child: _screen[_currentindex]),

      ///list of [index]
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ThemeController.isDark()
          ? (ColorFilter.mode(
              _currentindex == index ? Color(0xFF15B86C) : Color(0xFFC6C6C6),
              BlendMode.srcIn,
            ))
          : (ColorFilter.mode(
              _currentindex == index ? Color(0xFF15B86C) : Color(0xFF3A4640),
              BlendMode.srcIn,
            )),
    );
  }
}


//   _currentScreen = _screen[index ?? 0];
// // if (index == 0) {
//   screen = HomeScreen();
// } else if (index == 1) {
//   screen = TasksScreen();
// } else if (index == 2) {
//   screen = CompleteTasksScreen();
// } else {
//   screen = ProfileScreen();
// }