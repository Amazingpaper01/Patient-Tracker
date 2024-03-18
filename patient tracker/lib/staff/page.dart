import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text

class Page_Doctor extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<Page_Doctor> createState() => _Page();
}

class _Page extends State<Page_Doctor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: IconButton(
          icon: Image.asset(
                'assets/images/patient_logo.png',
                height: 80,
                width: 80,
            ),
          //iconSize: 70,
          onPressed: (){
            //
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Color(0xFF373C88),
              size: 40
            ),
            onPressed: (){
              //Navigator.pop(context);
            },
          ),
          SizedBox(width: 10),
        ],     
        backgroundColor: Color(0xFFF4F4F4),
      ),
      //body: add_patient(),
    );
  }
}
