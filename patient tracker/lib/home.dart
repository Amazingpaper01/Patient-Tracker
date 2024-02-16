import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  //const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: true,
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
            child: Text('Hello'),
          ),
        ),    
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF323264),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab1'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab2'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tab3'),
          ],
        ),     
      );
  }
}



class BottomNaviBar extends StatelessWidget {
  const BottomNaviBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomBar = Scaffold(
      //backgroundColor: Color(0xFF323264),
      
    );
    return bottomBar;
  }
}
