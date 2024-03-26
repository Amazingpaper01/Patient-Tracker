import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // go back login page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font


class patientHome extends StatefulWidget {
  //const ({super.key});

  @override
  State<patientHome> createState() => _patientHome();
}

class _patientHome extends State<patientHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: IconButton(
          icon: Image.asset(
                'assets/images/patient_logo.png',
                height: 80,
                width: 80,
            ),
          onPressed: (){
            /* go back Patient Home page*/
            Navigator.pop(context);
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
                PopupMenuItem(
                  value: 'logout',
                  //enabled: false,
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.accessibility,
          size: 40,
        ),
        backgroundColor: Color(0xFFF4F4F4),
        onPressed: (){},
      ),
      body: patientInfo(),
    );
  }
}

/*
class floatingButton extends StatelessWidget {
  //const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floating
    );
  }
}
*/

class patientInfo extends StatelessWidget {
  //const MyWidget({super.key});

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
                            Text(
                              'K',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'M',
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
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Kazuya',
                        style: GoogleFonts.roboto(
                          color: Color(0xFF373C88),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Mishima',
                        style: GoogleFonts.roboto(
                          color: Color(0xFF373C88),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Doctor: Joseph Green',
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
                /* patient details */
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
                    //mainAxisAlignment: MainAxisAlignment.start,
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
                            Text(
                              '123456',
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
                            Text(
                              'Red 3B',
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
                            Text(
                              'Male (He/Him)',
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
                            Text(
                              'B+',
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
                            Text(
                              'Knee injury',
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
                            Text(
                              'Ibuprofen',
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
                            Text(
                              'null',
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
                            Text(
                              'null',
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

