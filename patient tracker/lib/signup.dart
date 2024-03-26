import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // for Login Page
//import 'package:practice/user/home.dart';    // for Home Page
import 'package:practice/user/home.dart';    
import 'package:practice/user/patient.dart';
import 'package:practice/staff/home.dart';  // for doctor's Home Page
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text


class SignUp extends StatefulWidget {
  //const MyWidget({super.key});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  // API
  final String apiURL = 'http://10.62.78.58:3000/register';
  // create Controller
  final signUp_firstName = TextEditingController();
  final signUp_lastName = TextEditingController();
  final signUp_email = TextEditingController();
  final signUp_password = TextEditingController();
  final signUp_confirmPassword = TextEditingController();
  String result = '';
  String role = ''; 
  bool isVisible_1 = true;
  bool isVisible_2 = true;
  // ======

  @override
  void dispose() {
    signUp_firstName.dispose();
    signUp_lastName.dispose();
    signUp_email.dispose();
    signUp_password.dispose();
    //signUp_confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _postData() async{
    try{
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String>{
          'Content-Type':'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName':signUp_firstName.text,
          'lastName':signUp_lastName.text,
          'email':signUp_email.text,
          'password':signUp_password.text,
          //'confirmPassword':signUp_confirmPassword.text,
          'role':role,
        }),
      );

      if (response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'Name:${responseData['firstName']}';
        });
      }
      else {
        throw Exception('Failed to post data');
      }    
    }
    catch(e){
      setState(() {
        result = 'Error: $e';
      });
    }
  }
  // ======

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

    

    // function for button
    SignUp(){     
      final email = signUp_email.text;
      final password_1 = signUp_password.text;
      final password_2 = signUp_confirmPassword.text;

      debugPrint(signUp_firstName.text);
      debugPrint(signUp_lastName.text);
      debugPrint(signUp_email.text);
      debugPrint(signUp_password.text);
      
      // check empty textfields
      if (signUp_firstName.text.isEmpty || signUp_lastName.text.isEmpty 
            || signUp_email.text.isEmpty || signUp_password.text.isEmpty || signUp_confirmPassword.text.isEmpty){
        debugPrint('any field is empty');
      }
      else {
        // check password
        if (password_1 == password_2){
          // check doctor or not
          if (RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@communitymedical.org)$")
            .hasMatch(email)) {
            debugPrint('doctor email');
            // go to Login Page (main.dart)
            role = 'staff';
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page_Doctor()),
            );
            signUp_firstName.clear();
            signUp_lastName.clear();     
            signUp_email.clear();
            signUp_password.clear();   
            signUp_confirmPassword.clear(); 
          }
          else {
            if (RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.(com|edu|org|gov)$")
              .hasMatch(email)) {
              debugPrint('patient email');
              // go to Login Page (main.dart)
              role = 'user';
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page_User()),
              );
              signUp_firstName.clear();
              signUp_lastName.clear();     
              signUp_email.clear();
              signUp_password.clear();   
              signUp_confirmPassword.clear(); 
            } 
            else {
              debugPrint('email has a spelling mistake');
            }
          }
          debugPrint(role);
        }
        else {
          debugPrint("pasword doesn't match");
        }
      }    
    }

    return Scaffold(
      body: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60
                  ),
                  Stack (
                    clipBehavior: Clip.none,
                    children: [
                      Container (
                        width: 157,
                        height: 158,
                        decoration: ShapeDecoration(
                          color: Color(0xFFEFEFEF),
                          shape: OvalBorder(),
                        ),
                      ),
                      Positioned(
                        left: -6,
                        top: 5,
                        child: Image.asset(
                          'assets/images/patient_logo.png',
                          height: 148.81,
                          width: 171,
                        ),
                      ),              
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
                  SizedBox(height: 40),
                  Text(
                    'Register',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF373C88),
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.10,
                    ),
                  ),
                  SizedBox(height: 50),
                  /* Text Box for First Name */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: signUp_firstName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: 'Enter here...',
                      ),
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Text Box for Last Name */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: signUp_lastName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        hintText: 'Enter here...',
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Text Box for Email */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: signUp_email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter here...',
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your email';
                        }
                        if (value.isNotEmpty){
                          // check doctor or not
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
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Text Box for Password */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: signUp_password,
                      obscureText: isVisible_1,  // hidden password
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter here...',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible_1 ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: (){
                            setState(() {
                                isVisible_1 = !isVisible_1;
                            });
                          },
                        ),
                      ),
                      validator: (value){
                        if (value == null || value.isEmpty){
                          return 'Please enter you password';
                        } else
                        if (value.isNotEmpty){
                          if (signUp_password.text != signUp_confirmPassword.text){
                            return "Pasword doesn't match";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Text Box for Confirm Password */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: signUp_confirmPassword,
                      obscureText: isVisible_2,  // hidden password
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        hintText: 'Enter here...',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isVisible_2 ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: (){
                            setState(() {
                                isVisible_2 = !isVisible_2;
                            });
                          },
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your password';
                        } else
                        if(value.isNotEmpty){
                          if (signUp_password.text != signUp_confirmPassword.text){
                            return "Pasword doesn't match";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  /* Button for Sign In */
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF373C88),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: (){                    
                      if (formKey.currentState!.validate()){
                        _postData();
                        SignUp();
                        //signUp_firstName.clear();
                        //signUp_lastName.clear();     
                        //signUp_email.clear();
                        //signUp_password.clear();   
                        //signUp_confirmPassword.clear(); 
                      }  
                    }, 
                    child: const Text(
                      'Sign Up',
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
                  SizedBox(height: 40),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        Text(
                          'OR',
                          style: GoogleFonts.montserrat(
                            color: Color(0xFF373C88),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.10,
                          ),
                        ),
                        SizedBox(width: 10),
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
                  SizedBox(height: 30),
                  // == go to Sign Up page (signup.dart) ==  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF373C88),
                      foregroundColor: Colors.white, 
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                      signUp_firstName.clear();
                      signUp_lastName.clear();     
                      signUp_email.clear();
                      signUp_password.clear();   
                      signUp_confirmPassword.clear();       
                    },  
                    child: const Text(
                      'Log In',
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
                  SizedBox(height: 50),   
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
