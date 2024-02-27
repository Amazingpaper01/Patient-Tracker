import 'package:flutter/material.dart';
import 'package:practice/staff/patient.dart';
import 'package:practice/staff/home.dart';
import 'package:practice/staff/settings.dart';

class Page_Doctor extends StatefulWidget {
  const Page_Doctor({Key? key}) : super(key: key);

  @override
  State<Page_Doctor> createState() => _Page_Doctor();
}

class _Page_Doctor extends State<Page_Doctor> {
  static const screen = [
    Patient_Doctor(),
    Home_Doctor(),
    Settings_Doctor()
  ];

  int selectedIndex = 0;

  void onItemTapped(int index){
    setState((){
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        body: screen[selectedIndex],    
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF323264),
          selectedItemColor: Color.fromARGB(255, 124, 190, 240),
          unselectedItemColor: Colors.white,  // set icon color when unselected
          currentIndex: selectedIndex,
          onTap: onItemTapped,
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


