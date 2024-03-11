import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text

class Patient extends StatelessWidget {
  const Patient({Key? key}) : super(key: key);

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
        body: add_patient(),  
      );
  }
}

class add_patient extends StatefulWidget {
  //const MyWidget({super.key});
  @override
  State<add_patient> createState() => _add_patient();
}

class _add_patient extends State<add_patient> {

  // create Controller
  final TextEditingController patient_fname = TextEditingController();
  final TextEditingController patient_lname = TextEditingController();
  final TextEditingController patient_ID = TextEditingController();  

  newPatient(){
    debugPrint(patient_fname.text);
    debugPrint(patient_lname.text);
    debugPrint(patient_ID.text);
  }

  // create form
  Future<void> InputDialog(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(          
            child: Row(
              children: [
                Text(
                  'Add Patient',
                  style: TextStyle(
                    color: Color(0xBA4F96AC),
                  ),
                ),
                SizedBox(width: 90),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Color(0xBA4F96AC),
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                    newPatient(); 
                  },
                ),
              ],
            ),          
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // First Name
                Container(
                  width: 210,
                  height: 56,
                  child: TextField(
                    controller: patient_fname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter here...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Last Name
                Container(
                  width: 210,
                  height: 56,
                  child: TextField(
                    controller: patient_lname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      hintText: 'Enter here...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Patient ID
                Container(
                  width: 210,
                  height: 56,
                  child: TextField(
                    controller: patient_ID,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Patient ID',
                      hintText: 'Enter here...',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //primary:  // background
                          //onPrimary: // foreground
                          backgroundColor: Color(0xBA4F96AC),
                          foregroundColor: Colors.white, 
                        ),
                        onPressed: () {
                          // Add your logic here
                          Navigator.pop(context);
                          newPatient(); 
                        },
                        child: SizedBox(
                          width: 50,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [                   
                              Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 0.10,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),                    
                    ],
                  ),
                ),
              ],
            ),
          ),        
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50], // Color.(0xffE5E5E5)
      body: Container(   
        width: double.infinity,     
        child: Column(  
            //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,      
          children: [
            SizedBox(height: 70),
            Text(
              'Currently No Patients',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 0.07,
                letterSpacing: 0.10,
              ),
            ),            
            SizedBox(height: 30),
            Container(
              width: 320,
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
            SizedBox(height: 30),                          
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF49DAF9),
                foregroundColor: Colors.white
              ),
              onPressed: () {                
                InputDialog(context);         
              },  
              child: SizedBox(
                width: 143,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [                  
                    Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                    SizedBox(width: 8),
                    Text(
                      'New Patient',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                        letterSpacing: 0.10,
                      ),
                    ),
                  ]
                ),
              ),
            ),            
          ],
        ),
      ),
    );
  }
}

