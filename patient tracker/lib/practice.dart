import 'package:flutter/material.dart';

class Home_2 extends StatelessWidget {
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
            child: Practice(),
          ),
          /*
          body: Container (
            child: Login(),
        ),
        */
        ),         
        //const Login(),        
      );
  }
}

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            width: 210,
            height: 56,
            child: TextField(
              //controller: signIn_password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter here...',
              ),
            ),
          ),
    );
  }
}