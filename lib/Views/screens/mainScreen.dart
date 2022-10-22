
import 'package:flutter/material.dart';
import 'package:guard_app/Views/screens/earningScreen.dart';

import 'package:guard_app/Views/widgets/jobs.dart';
import 'package:guard_app/Views/widgets/mainScreenWidget.dart';


import 'package:guard_app/Views/widgets/profile.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    static  List<Widget> _pages = <Widget>[
  MainScreenWidget(),
  EarningScreen(),
  JobsScreen(),
  ProfileScreen()

];

    int _selectedIndex = 0;

     @override
  

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                icon: const Icon(Icons.home),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                
                },
                icon: const Icon(Icons.my_library_books),
              ),
              label: "Earnings"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
              
                },
                icon: const Icon(Icons.local_activity_outlined),
              ),
              label: "Jobs"),
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                
                },
                icon: const Icon(Icons.person_outline),
              ),
              label: "Profile"),
        ],
      ),
      body:  _pages[_selectedIndex]
    );
  }
}
