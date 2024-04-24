import 'package:flutter/material.dart';
import 'package:practice/main.dart';   // for login page 
import 'package:practice/view/user/patientDisplay.dart';  // to access the patientList
import 'package:practice/view/user/patientInfo.dart'; // go to patientInfo page
import 'package:practice/view/user/chat_page.dart'; // go to pharmacy page
import 'package:practice/view/user/vitals_page.dart';  // go to vitals page
import 'package:practice/view/user/calender_page.dart'; // go to calender page
import 'package:practice/view/user/notification_page.dart'; // go to notification page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial

/*
class pharmacyPage extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<pharmacyPage> createState() => _pharmacyPage();
}
*/

//class _pharmacyPage extends State<pharmacyPage> {
class pharmacyPage extends StatelessWidget {
  final listData sendListData;
  pharmacyPage(this.sendListData); // store the patientList[index] data

  @override
  Widget build(BuildContext context) {
    /* App Bar */
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
        icon: Icons.medical_services_outlined, // pharmacy icon
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
          /* Notificatin History */
          SpeedDialChild(
            child: Icon(
              Icons.description_outlined,
              color: Color(0xFF373C88),
            ),
            backgroundColor: Color(0xFFECE6F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => notificationPage(sendListData)), // go to notification page
              );                
            }
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
                MaterialPageRoute(builder: (context) => calenderPage(sendListData)), // go to pharmacy page
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
      body: pharmacy(),
    );
  }
}

class pharmacy extends StatelessWidget {
  //const requestChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Pharmacy',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}