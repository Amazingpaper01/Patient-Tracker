import 'package:flutter/material.dart';

class Settings_Doctor extends StatelessWidget {
  const Settings_Doctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(
            color: Colors.white    // change back button color
          ),
          title: const Text(
            "Settings",
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
      );
  }
}


