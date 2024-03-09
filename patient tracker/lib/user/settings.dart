import 'package:flutter/material.dart';
import 'package:practice/main.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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