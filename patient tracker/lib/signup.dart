import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // for Login Page
import 'package:practice/view/user/home.dart';  // for Home Page
import 'package:practice/view/staff/home.dart';  // for doctor's Home Page
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text

/* create SignUp page */
class SignUp extends StatefulWidget {
  //const MyWidget({super.key});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  /* API */
  final String apiURL = 'https://projpatienttracker.azurewebsites.net/auth/register';  // backend URL

  /* create Controller */
  final TextEditingController signUp_firstName = TextEditingController();
  final TextEditingController signUp_lastName = TextEditingController();
  final TextEditingController signUp_email = TextEditingController();
  final TextEditingController signUp_password = TextEditingController();
  final TextEditingController signUp_confirmPassword = TextEditingController();
  
  String result = '';  // To store the result from the API call
  String role = '';   // store the role: staff or user
  bool isVisible_1 = true;  // show the password or not
  bool isVisible_2 = true;  // show the password or not
  /* =========================================================== */
  /* POST request: SignUp */
  //Future<void> _postData() async{
  void postRequest_signup() async{
    print("test");
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
          'role':role,
        }),
      );
      final responseData = jsonDecode(response.body);
      final resultString = jsonEncode(responseData);
      if (response.statusCode == 200){
        /* Successful POST request, handle the reponse here */
        setState(() {
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
    catch(e){
      setState(() {
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
    SignUp(){     
      final email = signUp_email.text;
      final password_1 = signUp_password.text;
      final password_2 = signUp_confirmPassword.text;

      debugPrint(signUp_firstName.text);
      debugPrint(signUp_lastName.text);
      debugPrint(signUp_email.text);
      debugPrint(signUp_password.text);
      
      /* check empty textfields */
      if (signUp_firstName.text.isEmpty || signUp_lastName.text.isEmpty 
            || signUp_email.text.isEmpty || signUp_password.text.isEmpty || signUp_confirmPassword.text.isEmpty){
        debugPrint('any field is empty');
      }
      else {
        /* check password */
        if (password_1 == password_2){
          /* check doctor or not */
          if (RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@communitymedical.org)$")
            .hasMatch(email)) {
            debugPrint('doctor email');
            /* go to Doctor's Home Page (staff/home.dart) */
            role = 'staff';
            postRequest_signup();
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
              /* go to User's Home Page (user/home.dart) */
              role = 'user';
              postRequest_signup();
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

    // ===========================================================

    /* Main Part of Sign Up Page*/
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
                      /* Backfround Circle */
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
                  SizedBox(height: 40),
                  /* Text: Register */
                  Text(
                    'Register',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF373C88),
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
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
                          /* check doctor or not */
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
                        SignUp();
                        //postRequest_signup(); // send POST request
                      }  
                    }, 
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  /* Text: --- OR --- */
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
                  SizedBox(height: 30),
                  /* go to Sign Up page (signup.dart) */
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
