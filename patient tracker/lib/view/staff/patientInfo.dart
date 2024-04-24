import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // go back login page
import 'package:practice/view/staff/edit_patientInfo.dart'; // edit patientIngo page
import 'package:practice/view/staff/patientDisplay.dart'; // to access the patientList
import 'package:practice/view/staff/home.dart'; // go to home page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON


bool isEdit = false;

//class _patientHome extends State<patientHome> {
  /*
class patientHome extends StatefulWidget {
  //const MyWidget({super.key});
  final listData1 sendListData1;
  patientHome(this.sendListData1); 

  @override
  State<patientHome> createState() => _patientHome(sendListData1);
}
*/
class patientHome extends StatelessWidget {
//class _patientHome extends State<patientHome> {
  final listData1 sendListData;
  final int indexNum;
  patientHome(this.sendListData, this.indexNum); // store the patientList[index] data

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        /* Logo Image Button */
        title: IconButton(
          icon: Image.asset(
                'assets/images/patient_logo.png',
                height: 80,
                width: 80,
            ),
          onPressed: (){
            /* go back Patient Home page*/
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page_Doctor()), // go to user's pages
            );
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
                  MaterialPageRoute(builder: (context) => LogIn()), // go to user's pages
                );
                patientList1.clear();                
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
                /* LogOut Button */
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Log Out',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF373C88),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 0.06,                        
                    ),
                  ),
                ),
              ];
            }
          ),
        ],
        backgroundColor: Color(0xFFF4F4F4),
      ),
      /* create the Menu Button */
      floatingActionButton: SpeedDial(
        icon: Icons.edit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Color(0xFFECE6F0),
        onPress: (){
          /*
          setState(){
            isEdit = true;
          }
          */
          /*
          setState( (){
            isEdit != isEdit;
          });
          */
          //editPatientInfo();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => patientHome_edit(sendListData, indexNum)), // go to user's pages
          );
        },
      ),
      //body: patientInfo(sendListData)
      body: patientInfo(sendListData, indexNum)
    );
  }
}

/* show Patient Information */
class patientInfo extends StatelessWidget {
  //const MyWidget({super.key});
  final listData1 sendListData1;
  final int indexNum;
  patientInfo(this.sendListData1, this.indexNum);  // store the patientList[index] data

  /* API */
  //final String apiURL = 'http://10.62.77.52:3000/auth/login'; // backend URL
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                /* Icon with initial, Patient Name, doctor name */
                ListTile(      
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [                                                    
                      CircleAvatar(
                        backgroundColor: Color(0xFF373C88),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /* Initial First Name */
                            Text(
                              '${sendListData1.initial_fName}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            /* Initial Last Name */
                            Text(
                              '${sendListData1.initial_lName}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 3),
                    ],
                  ),
                  /* Patient name */
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /* First name */
                      Text(
                        '${sendListData1.fName}',
                        style: GoogleFonts.roboto(
                          color: Color(0xFF373C88),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      /* Last Name */
                      Text(
                        '${sendListData1.lName}',
                        style: GoogleFonts.roboto(
                          color: Color(0xFF373C88),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  /* Doctor Name */
                  subtitle: Text(
                    'Doctor: ${sendListData1.doctorName}',
                    style: GoogleFonts.roboto(
                      color: Color(0xFF373C88),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                /* Icon */
                Container(                
                  child: Icon(
                    Icons.account_circle,
                    size: 200,
                    color: Color(0xff6750A4),
                  ),
                ),
                /* Text: patient details */
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Patient Details',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xFF1D1B20),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(                  
                    crossAxisAlignment: CrossAxisAlignment.start,                  
                    children: [
                      /* Patient ID */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Patient ID: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Patient ID number (6 digit) */
                            Text(
                              '',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Hospital */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Hospital: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Hospital Name */
                            Text(
                              'Clovis Community Hospital',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Room */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Room: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Room Number */
                            Text(
                              '${sendListData1.room}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Gender */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Gender */
                            Text(
                              '${sendListData1.gender}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Bloodtype */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Bloodtype: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Blood Type */
                            Text(
                              '${sendListData1.bloodType}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Condition */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Condition: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Paitient Condition */
                            Text(
                              '${sendListData1.condition}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Medication */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Medication: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Type of Medication */
                            Text(
                              '${sendListData1.medication}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Admission Date */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Admission Date: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Admission Date */
                            Text(
                              '',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      /* Discharge Date */
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: [
                            Text(
                              'Discharge Date: ',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            /* Discharge Date */
                            /*
                            Text(
                              'null',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            */
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],      
      ),
    );
  }
}
