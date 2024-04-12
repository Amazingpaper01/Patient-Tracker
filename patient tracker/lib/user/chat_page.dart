import 'package:flutter/material.dart';
import 'package:practice/user/patient.dart';  // to access the patientList
import 'package:practice/main.dart';   // for login page 
import 'package:practice/user/patientInfo.dart'; // go to patientInfo page
import 'package:practice/user/pharmacy_page.dart'; // go to pharmacy page
import 'package:practice/user/vitals_page.dart';  // go to vitals page
import 'package:practice/user/calender_page.dart'; // go to calender page
import 'package:practice/user/notification_page.dart'; // go to notification page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial


class chatPage extends StatefulWidget {
  //const MyWidget({super.key});
  final listData sendListData;
  chatPage(this.sendListData); // store the patientList[index] data

  @override
  State<chatPage> createState() => _chatPage();
}

//int sendChatRequest = 0;
bool sendChatRequest = false;


class _chatPage extends State<chatPage> {
//class chatPage extends StatelessWidget {
  //final listData sendListData;
  //_chatPage(this.sendListData); // store the patientList[index] data

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => patientHome(widget.sendListData)), // go to user's pages
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
        icon: Icons.forum_outlined, // chat icon
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
                MaterialPageRoute(builder: (context) => notificationPage(widget.sendListData)), // go to notification page
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
                MaterialPageRoute(builder: (context) => calenderPage(widget.sendListData)), // go to calender page
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
                MaterialPageRoute(builder: (context) => vitalsPage(widget.sendListData)), // go to vitals page
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
                MaterialPageRoute(builder: (context) => pharmacyPage(widget.sendListData)), // go to pharmacy page
              );                
            }
          ),
          /* Patient Information*/
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
                MaterialPageRoute(builder: (context) => patientHome(widget.sendListData)), // go to patientInfo page
              );                
            }
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Chat with Staff',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40),
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
            sendChatRequest ? pendingRequest() : selectRequest(),  // condition ? true : false
            SizedBox(height: 30),  
            SizedBox(
              height: 40,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF373C88),
                  foregroundColor: Colors.white, 
                ),
                onPressed: (){                  
                  debugPrint(sendChatRequest.toString());
                  setState((){
                    sendChatRequest = !sendChatRequest;
                  });
                  debugPrint(sendChatRequest.toString());                  
                },
                child: /*Text(
                  'Send Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500
                  ),
                ), 
                */               
                sendChatRequest ? Text(
                  'Join Chat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500
                  ),
                ) : 
                Text(
                  'Send Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* Select Request Reason */
class selectRequest extends StatefulWidget {
  const selectRequest({super.key});

  @override
  State<selectRequest> createState() => _selectRequest();
}

class _selectRequest extends State<selectRequest> {
  String? selectedReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'What is the primary concern for wanting\nto contact your provider?',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30),
          /* Reason for chat */
          Container(
            width: 250,
            child: DropdownButtonFormField(
              hint: Text('  Select'),
              items: const [
                DropdownMenuItem(
                  child: Text('Change in condition'),
                  value: '1',
                ),
                DropdownMenuItem(
                  child: Text('Reschedule appointment'),
                  value: '2',
                ),
                DropdownMenuItem(
                  child: Text('Request medical records'),
                  value: '3',
                ),
                DropdownMenuItem(
                  child: Text('Other'),
                  value: 'Other',
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  selectedReason = value!;
                  //text_gender = value;
                });
              },
              value: selectedReason,                              
              dropdownColor: Color(0xFFF5F5F5),              
              decoration: InputDecoration(
                //labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              /*
              validator: (value) {
                if (value == null || value.isEmpty){
                  return 'Please select gender';
                }
                return null;
              },
              */
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}


/* Pend Chat Request */
class pendingRequest extends StatefulWidget {
  const pendingRequest({super.key});

  @override
  State<pendingRequest> createState() => _pendingRequest();
}


class _pendingRequest extends State<pendingRequest> {
  //const MyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Request sent.\nPlease join the chat using the button\nbelow and remain connected until a\nprovider joins.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}
