import 'package:flutter/material.dart';
import 'package:practice/main.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text


class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: false,
          title: Stack (
            clipBehavior: Clip.none,
            children: [
              //SizedBox(width: 100),
              Container (
                width: 45,
                height: 45,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5899999737739563),
                  shape: OvalBorder(),
                ),
              ),
              Positioned(
                left: -4.5,
                top: -2,
                child: Image.asset(
                  'assets/images/patient_logo.png',
                  height: 55,
                  width: 55,
                ),
              ),              
              Positioned(
                left: 30,
                top: 20,
                child: StrokeText(
                  text: 'atient',
                  textStyle: GoogleFonts.libreBodoni(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  strokeColor: Color(0xFF323264),
                  strokeWidth: 5,
                ),
              ),
              //Text('Patient'),             
            ],
          ),        
          backgroundColor: const Color(0xFF323264),
        ),
        body: Logout(),
      );
  }
}

class Logout extends StatelessWidget {
  //const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    LogOut(){
      debugPrint('patient email');
      // go back to Login Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogIn()), // go to user's pages
      );
    }

    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Center(
        //width: 146,
        //height: 40,
        child: SizedBox(
          width: 146,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF49DAF9),
                foregroundColor: Colors.white,
              ),
            onPressed: () {
                LogOut(); //LogIn
                //postRequest();              
            },  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0.10,
                    letterSpacing: 0.10,
                  ),                 
                ),
                SizedBox(width: 8),
                Icon(
                    Icons.logout,
                    color: Colors.white,
                ),
              ],
            ),
          ),
        ),        
      ),
    );
  }
}