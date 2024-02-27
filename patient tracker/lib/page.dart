import 'package:flutter/material.dart';
import 'package:practice/patient.dart'; // for Patient Information Page
import 'package:practice/home.dart';    // for Home Page
import 'package:practice/settings.dart'; // for Settings Page

class Page_User extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<Page_User> createState() => _Page();
}

class _Page extends State<Page_User> {
  // set bottom navigation bar
  static const _screen = [
    Patient(),
    Home(),
    Settings()
  ];

  int selectedIndex = 0;
  void _onItemTapped (int index){
    setState((){
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screen[selectedIndex],  
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF323264),
          selectedItemColor: Color.fromARGB(255, 124, 190, 240),
          unselectedItemColor: Colors.white,  // set icon color when unselected
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person), 
              label: 'Patient',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home), 
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings), 
              label: 'Setting'
            ),
          ],
        ),     
      );
  }
}
