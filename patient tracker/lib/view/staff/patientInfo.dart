import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // go back login page
import 'package:practice/view/staff/edit_patientInfo.dart'; // edit patientIngo page
import 'package:practice/view/staff/patientDisplay.dart'; // to access the patientList
import 'package:practice/view/staff/home.dart'; // go to home page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'package:intl/intl.dart'; // for DateTime format


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
  // final List<InfoData> sendListData;
  // patientHome(this.sendListData); // store the patientList[index] data
  //print(sendListData);
  final List<listData1> sendListData; 
  final int numIndex;
  patientHome(this.sendListData,this.numIndex);

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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => patientHome_edit(sendListData, numIndex)), // go to user's pages
          );
        },
      ),
      //body: patientInfo(sendListData)
      body: patientInfo(sendListData, numIndex)
    );
  }
}

final dateFormat = DateFormat('yyyy/MM/dd');

/* show Patient Information */
class patientInfo extends StatelessWidget {
  //const MyWidget({super.key});
  // final List<InfoData> sendListData1;
  // patientInfo(this.sendListData1);  // store the patientList[index] data
  final int numIndex;
  final List<listData1> sendListData; 
  patientInfo(this.sendListData, this.numIndex);  

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
                              '${sendListData.first.initial_fName}',//'${patientList1[numIndex].initial_fName}',//'',//'${sendListData1.initial_fName}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            /* Initial Last Name */
                            Text(
                              '${sendListData.first.initial_lName}',//'${patientList1[numIndex].initial_lName}',//'',//'${sendListData1.initial_lName}',
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
                        '${sendListData.first.fName}',//'${patientList1[numIndex].fName}',//'',//'${sendListData1.fName}',
                        style: GoogleFonts.roboto(
                          color: Color(0xFF373C88),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      /* Last Name */
                      Text(
                        '${sendListData.first.lName}',//'${patientList1[numIndex].lName}',//'',//'${sendListData1.lName}',
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
                    '${sendListData.first.doctorName}',//'${patientList1[numIndex].doctorName}',//'',//'Doctor: ${sendListData1.doctorName}',
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
                              '${sendListData.first.patientID}',//'${patientList1[numIndex].patientID}',//'',
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
                              '${sendListData.first.room}',//'${patientList1[numIndex].room}',//'${sendListData1.room}',
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
                              '${sendListData.first.gender}',//'${patientList1[numIndex].gender}',//'${sendListData1.gender}',
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
                              '${sendListData.first.bloodType}',//'${patientList1[numIndex].bloodType}',//'',//'${sendListData1.bloodType}',
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
                              '${sendListData.first.condition}',// '${patientList1[numIndex].condition}',//'',//'${sendListData1.condition}',
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
                              '${sendListData.first.medication}',//'${patientList1[numIndex].medication}',//'',//'${sendListData1.medication}',
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
                              '${dateFormat.format(sendListData.first.admDate)}',//'${dateFormat.format(patientList1[numIndex].admDate)}',//'${}',
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
                            Text(
                              '${dateFormat.format(sendListData.first.disDate)}',//'${dateFormat.format(patientList1[numIndex].disDate)}',//'${patientList1[numIndex].disDate}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF49454F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
          ),
        ],      
      ),
    );
  }
}
