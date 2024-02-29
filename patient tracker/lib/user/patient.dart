import 'package:flutter/material.dart';

class Patient extends StatelessWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(
            color: Colors.white    // change back button color
          ),         
          title: const Text(
            "Patient Information",
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
        body: add_patient(),  
      );
  }
}

class add_patient extends StatelessWidget {
  // const MyWidget({super.key});

  newPatient(){

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
                primary: Color(0xFF49DAF9), // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                newPatient(); //LogIn            
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