import 'package:flutter/material.dart';
import 'package:practice/main.dart';   // for login page 
import 'package:practice/view/user/patientDisplay.dart';  // to access the patientList
import 'package:practice/view/user/patientInfo.dart'; // go to patientInfo page
import 'package:practice/view/user/chat_page.dart'; // go to chat page
import 'package:practice/view/user/pharmacy_page.dart'; // go to pharmacy page
import 'package:practice/view/user/vitals_page.dart';  // go to vitals page
import 'package:practice/view/user/calender_page.dart'; // go to notification page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial

/*
class notificationPage extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<notificationPage> createState() => _notificationPage();
}
*/

//class _notificationPage extends State<notificationPage> {
class notificationPage extends StatelessWidget {
  final listData sendListData;
  notificationPage(this.sendListData); // store the patientList[index] data

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
              MaterialPageRoute(builder: (context) => patientHome(sendListData)), // go to user's pages
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
                  MaterialPageRoute(builder: (context) => LogIn()), // go to patient home pages
                );  
                patientList.clear();               
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
        icon: Icons.description_outlined, // notification history icon
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Color(0xFFECE6F0),
        overlayColor:  Colors.white,
        overlayOpacity: 0.4,
        children: [
          /* close button */
          SpeedDialChild(
            child: Icon(
              Icons.expand_circle_down_outlined,
              color: Color(0xFFECE6F0),
            ),
            backgroundColor: Color(0xFF373C88),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          /* Calender */
          SpeedDialChild(
            child: Icon(
              Icons.date_range_outlined,
              color: Color(0xFF373C88),
            ),
            backgroundColor: Color(0xFFECE6F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => calenderPage(sendListData)), // go to notification page
              );                
            }
          ),
          /* Vitals */
          SpeedDialChild(
            child: Icon(
              Icons.thermostat_auto_outlined,
              color: Color(0xFF373C88),
            ),
            backgroundColor: Color(0xFFECE6F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => vitalsPage(sendListData)), // go to vitals page
              );                
            }
          ),
          /* Pharmacy */
          SpeedDialChild(
            child: Icon(
              Icons.medical_services_outlined,
              color: Color(0xFF373C88),
            ),
            backgroundColor: Color(0xFFECE6F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pharmacyPage(sendListData)), // go to pharmacy page
              );                
            }
          ),
          /* Chat with Doctor */
          SpeedDialChild(
            child: Icon(
              Icons.forum_outlined,
              color: Color(0xFF373C88),
            ),
            backgroundColor: Color(0xFFECE6F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => chatPage(sendListData)), // go to calender page
              );                
            }
          ),
          /* Patient Information  */
          SpeedDialChild(
            child: Icon(
              Icons.accessibility,
              color: Color(0xFF373C88),
            ),
            backgroundColor: Color(0xFFECE6F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => patientHome(sendListData)), // go to patientInfo page
              );                
            }
          ),  
        ],
      ),
      body: notificationHistory(),
    );
  }
}

class notificationHistory extends StatelessWidget {
  //const requestChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Notifications',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }
}