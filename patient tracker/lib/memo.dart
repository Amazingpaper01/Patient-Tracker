import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // for Login Page
//import 'package:practice/home.dart';    // for Home Page
//import 'package:practice/home_doctor.dart'; // for Doctor's Home page 
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';

class SignUp extends StatelessWidget {
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
            child: Signup_Form(),
          ),
        ),         
      );
  }
}
/*
// create Login page 
class SignUp extends StatelessWidget {
  const SignUp({Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUp = Align(
      alignment: Alignment.center,
      child: Signup_Form(),
    );
    
    return signUp;
  }
}
*/

class Signup_Form extends StatefulWidget {
  //const Login_Form({Key? key}) : super(key: key);

  @override
  _Signup_FormState createState() => _Signup_FormState();
}


class _Signup_FormState extends State<Login_Form> {
  //const _Login_FormState({Key? key} ) : super(key: key);
  //bool _isObscure = true; // show the password or not

  // API
  final String apiURL = 'http://backend'; // backend URL
  // create Controller
  final signUp_firstName = TextEditingController();
  final signUp_lastName = TextEditingController();
  final signUp_email = TextEditingController();
  final signUp_password = TextEditingController();
  final signUp_confirmPassword = TextEditingController();
  
  String result = ''; // To store the result from the API call

  // ===========
  @override
  void dispose(){
    signUp_firstName.dispose();
    signUp_lastName.dispose();
    signUp_email.dispose();
    signUp_password.dispose();
    signUp_confirmPassword.dispose();
    super.dispose();
  }

  Future <void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-TYpe': 'application/json; charset = UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName':signUp_firstName.text,
          'lastName':signUp_lastName.text,
          'email': signUp_email.text,
          'password': signUp_password.text,
          'confirmPassword':signUp_confirmPassword.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successful POST request, handle the reponse here
        final responseData = jsonDecode(response.body);
        setState((){
          result = 'FirstName: ${responseData['firstName']}\nLastName: ${responseData['lastName']}\nEmail: ${responseData['email']}\nPassword: ${responseData['password']}\nConfirmPassword: ${responseData['confirmPassword']}';
        });
      }
      else {
        // if the server returns an error response, thrown an exception
        throw Exception('Failed to post data');
      }
    }
    catch (e) {
      setState((){
        result = 'Error: $e';
      });
    }
  }

  // ============
  @override
  Widget build(BuildContext context) { 
    /*
    // function for button   
    void SignIn(){
      final email = signIn_email.text;
      debugPrint(signIn_email.text);
      debugPrint(signIn_password.text);
      // go to Home Page (home.dart)

      // check doctor or not
      if (RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@communitymedical.org)$")
        .hasMatch(email)) {
        debugPrint('doctor email');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home_Doctor()),
        );
        }
      else {
        if (RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.(com|edu|org|gov)$")
          .hasMatch(email)) {
          debugPrint('patient email');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } 
        else {
          debugPrint('Error');
        }
      }
    }  
    */
    // function for button
    void SignUp(){
      debugPrint(signUp_firstName.text);
      debugPrint(signUp_lastName.text);
      debugPrint(signUp_email.text);
      debugPrint(signUp_password.text);
      debugPrint(signUp_confirmPassword.text);
      // go to Login Page (main.dart)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    }
    

    // main funciton
    final signUp_form = Container(
      width: 322,
      height: 680,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [          
          // Title - Sign In
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Istok Web',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          // Text Box for First Name
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signUp_firstName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Text Box for Last Name
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signUp_lastName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Text Box for Email
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signUp_email,
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
              controller: signUp_password,
              obscureText: true,  // hidden password
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Text Box for Confirm Password
          Container(
            width: 210,
            height: 56,
            child: TextField(
              controller: signUp_confirmPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                hintText: 'Enter here...',
              ),
            ),
          ),
          // Button for Sign In
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              //primary: Color(0xFF6750A4), // background
              //onPrimary: Colors.white, // foreground
              backgroundColor: Color(0xFF6750A4),
              foregroundColor: Colors.white,
            ),
            onPressed: (){
              _postData();
              SignUp();
            }, 
            child: const Text(
              'Create Account',
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
          // go to Sign In page
          TextButton(
            onPressed: (){
              //Navigator.pop(context);
              signUp_firstName.clear();
              signUp_lastName.clear();     
              signUp_email.clear();
              signUp_password.clear();   
              signUp_confirmPassword.clear();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogIn()),
              );             
              
            }, 
            child: const Text(
              "Already Have an Account? Sign In",
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
    
    return signUp_form;
  }
}


