import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(
            color: Colors.white    // change back button color
          ),         
          title: const Text(
            "Home",
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
            child: Text('Hello :)'),
          ),
        ),
      );
  }
}