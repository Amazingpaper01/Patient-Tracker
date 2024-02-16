import 'package:flutter/material.dart';
import 'package:practice/signup.dart';
import 'package:practice/practice.dart';

/*
void main(){
  runApp(Login());
}
*/
// create Login page 
class Login extends StatelessWidget {
  const Login({Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logIn = Align(
      alignment: Alignment.center,
      child: Login_Form(),
    );
    
    return logIn;
  }
}

// create sign up form
class Login_Form extends StatelessWidget {
  const Login_Form({Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // create Controller
    final signIn_email = TextEditingController();
    final signIn_password = TextEditingController();

    

    // function for button
    SignIn(){
      debugPrint(signIn_email.text);
      debugPrint(signIn_password.text);
    }

    // main funciton
    final logIn_form = Container(
      width: 322,
      height: 447,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [          
          // Title - Sign In
          const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Istok Web',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          // Text Box for Email
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signIn_email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Text Box for Password
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signIn_password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Button for Sign In
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF6750A4), // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: SignIn, 
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.10,
                letterSpacing: 0.10,
              ),
            ),
          ),
          // go to different page
          
          TextButton(
            onPressed: (){
              //Navigator.pop(context);
              signIn_email.clear();
              signIn_password.clear();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Practice()),
              );
            },
            child: const Text(
            "Don't Have an Account? Sing Up",
            style: TextStyle(
              color: Color(0xFF0000FF),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,   
              decoration: TextDecoration.underline, 
              decorationColor: Color(0xFF0000FF),          
              height: 0.09,
              letterSpacing: 0.50,
              
            ),
          ),
          ), 
          
      ]),
    );
    
    return logIn_form;
  }
}