import 'package:flutter/material.dart';

class Home_Doctor extends StatelessWidget {
  //const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(
            color: Colors.white    // change back button color
          ),
          title: const Text(
            "Patient Tracker",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            textAlign: TextAlign.center,
            ),          
          backgroundColor: const Color(0xFF323264),
          ),
        body: Scaffold(
          backgroundColor: Colors.orange[50],
          body: Center(
            child: Text('Hello doctor :)'),
          ),
        ),    
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF323264),
          selectedItemColor: Color.fromARGB(255, 124, 190, 240),
          unselectedItemColor: Colors.white,  // set icon color when unselected
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.flutter_dash), 
              label: 'Tab1',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home), 
              label: 'Tab2'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings), 
              label: 'Tab3'
            ),
          ],
        ),     
      );
  }
}


