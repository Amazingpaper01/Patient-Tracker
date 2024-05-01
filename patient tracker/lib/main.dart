import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practice/signup.dart';  // for SignUp page
import 'package:practice/view/user/home.dart';   // for users' Home Page 
import 'package:practice/view/staff/home.dart';  // for doctors' Home Page
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'dart:async';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // for riverpod


void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // remove the debug sign on the right top
      home: LogIn(),
    );
  }
}

/* create LogIn page */
class LogIn extends StatefulWidget {
  //const Login_Form({Key? key}) : super(key: key);
  @override
  _LogIn createState() => _LogIn();
}


class _LogIn extends State<LogIn> {
  /* API */
  final String apiURL = 'https://projpatienttracker.azurewebsites.net/auth/login'; // backend URL

  /* create Controller */
  final TextEditingController signIn_email = TextEditingController();
  final TextEditingController signIn_password = TextEditingController();  
  
  String result = ''; // To store the result from the API call
  bool isVisible = true; // show the password or not

  /* =========================================================== */
  /* POST request: logIn */
  //Future <void> postRequest() async {
  void postRequest() async {
    print("test");
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': signIn_email.text,
          'password': signIn_password.text
        }),
      );
      final responseData = jsonDecode(response.body);
      final resultString = jsonEncode(responseData);
      if (response.statusCode == 200) {
        /* Successful POST request, handle the reponse here */    
        setState((){
          result = resultString;
          print(resultString);
        });
      }
      else {
        /* if the server returns an error response, thrown an exception */
        //throw Exception('Failed to post data');
        print(resultString);
      }
    }
    catch (e) {
      setState((){
        result = 'Error: $e';
        print(result);
      });
    }
  }
  
  /* =========================================================== */
  
  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    /* function for button */
    void LogIn(){      
      final email = signIn_email.text;
      debugPrint(signIn_email.text);
      debugPrint(signIn_password.text);

      /* check empty textfield */
      if (signIn_email.text.isEmpty || signIn_password.text.isEmpty){
        debugPrint('any field is empty');        
      }
      else {
        /* check email */
        if (RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@communitymedical.org)$")
          .hasMatch(email)) {
          //debugPrint('doctor email');
          /* go to Doctor's Home Page (staff/home.dart) */
          postRequest();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page_Doctor()), // go to doctor's pages
          );
          signIn_email.clear();
          signIn_password.clear();
        }
        else {
          if (RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.(com|edu|org|gov)$")
            .hasMatch(email)) {
            //debugPrint('patient email');
            /* go to User's Home Page (user/home.dart) */
            postRequest();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page_User()), // go to user's pages
            );
            signIn_email.clear();
            signIn_password.clear();
          } 
          else {
            debugPrint('email is incorrect');
          }
        }
      }      
    }

    // ===========================================================

    /* Main Part of the LogIn Page */
    return Scaffold(
      body: Container( 
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 60
              ),
              /* Logo */
              Stack (
                clipBehavior: Clip.none,
                children: [
                  /* Background Circle */
                  Container (
                    width: 157,
                    height: 158,
                    decoration: ShapeDecoration(
                      color: Color(0xFFEFEFEF),
                      shape: OvalBorder(),
                    ),
                  ),
                  /* Logo Image */
                  Positioned(
                    left: -6,
                    top: 5,
                    child: Image.asset(
                      'assets/images/patient_logo.png',
                      height: 148.81,
                      width: 171,
                    ),
                  ),   
                  /* Blue Outlined Circle */           
                  Positioned(
                    left: 5.5,
                    top: 5.5,
                    child: Container (
                      width: 144.89,
                      height: 144.89,
                      decoration: ShapeDecoration(
                        color: Color(0x00D9D9D9),
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 4,
                            color: Color(0xFF373C88),
                          ),
                        ),
                      ),
                    ),
                  ),              
                ],
              ),
              SizedBox(height: 65),
              /* Text: Welcome */
              Text(
                'WELCOME',
                style: GoogleFonts.montserrat(
                  color: Color(0xFF373C88),
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 65),
              /* Text Box for Email */
              Container(
                width: 210,
                child: TextFormField(                
                  controller: signIn_email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter here...',
                  ),
                  /* error message */
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return 'Please enter your email';
                    }
                    if (value.isNotEmpty) {
                      if (RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@communitymedical.org)$")
                        .hasMatch(value)) {
                        return null;
                      }
                      else {
                        if (RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.(com|edu|org|gov)$")
                          .hasMatch(value)) {
                          return null;
                        } 
                        else {
                          return 'Not a valid email';
                        }
                      }
                    }
                    return null;
                  }                            
                ),
              ),            
              SizedBox(height: 25),
              /* Text Box for Password */
              Container(
                width: 210,
                child: TextFormField(
                  controller: signIn_password,
                  obscureText: isVisible,  // hidden password
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter here...',                  
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: (){
                        setState(() {
                            isVisible = !isVisible;
                        });
                      },
                    ), 
                  ),
                  /* error message */
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return 'Please enter your passwords';
                    }
                    return null;                  
                  },
                ),
              ),
              SizedBox(height: 50),
              /* Button for Log In */
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF373C88),
                  foregroundColor: Colors.white, 
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()){
                    LogIn(); //LogIn
                  }        
                },  
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 40),
              /* Text: --- Or --- */
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* underbar */
                    Container(
                      width: 134,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFCAC4D0),
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 10),
                    /* Text: OR */
                    Text(
                      'OR',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF373C88),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    /* underbar */
                    Container(
                      width: 134,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFCAC4D0),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              /* go to Sign Up page (signup.dart) */
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF373C88),
                  foregroundColor: Colors.white, 
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                  signIn_email.clear();
                  signIn_password.clear();        
                },  
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),   
            ],
          ),
        ),
      ),
    );
  }
}
