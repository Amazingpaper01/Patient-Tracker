import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/user/patient.dart'; // for Patient Information Page
//import 'package:practice/user/patient.dart';
import 'package:practice/main.dart';    
import 'package:google_fonts/google_fonts.dart'; // for using Google Font

class Page_User extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<Page_User> createState() => _Page();
}

class _Page extends State<Page_User> {

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
          onPressed: (){
            //
          },
        ),
        actions: <Widget> [
          PopupMenuButton<String>(
            offset: Offset(0.0, 50), // position
            constraints: BoxConstraints.expand(width: 120, height: 65), // size
            color: Color(0xFFF4F4F4),  // color
            surfaceTintColor: Color(0xFFF4F4F4),  // color
            onSelected: (String value) async {
              if (value == 'logout'){                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogIn()), // go to patient home pages
                );                
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child:CircleAvatar(
                child: Icon(
                  Icons.account_circle,
                  color: Color(0xFF373C88),
                  size: 40,                
                ),
                backgroundColor: Color(0xFFF4F4F4),
              ),
            ),            
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'logout',
                  //enabled: false,
                  child: Text('Log Out',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF373C88),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
          
              ];
            }
          ),
        ],
        backgroundColor: Color(0xFFF4F4F4),
      ),
      body: add_patient(),
    );
  }
}

