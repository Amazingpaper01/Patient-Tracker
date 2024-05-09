import 'package:flutter/material.dart';
import 'package:practice/main.dart';   // for login page 
import 'package:practice/user/patient.dart';  // to access the patientList
import 'package:practice/user/patientInfo.dart'; // go to patientInfo page
import 'package:practice/user/chat_page.dart'; // go to chat page
import 'package:practice/user/pharmacy_page.dart'; // go to pharmacy page
import 'package:practice/user/vitals_page.dart';  // go to vitals page
import 'package:practice/user/notification_page.dart'; // go to notification page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial
import 'package:intl/intl.dart';

class calenderPage extends StatelessWidget {
  final listData sendListData;
  calenderPage(this.sendListData); // store the patientList[index] data
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
        icon: Icons.date_range_outlined, // calender icon
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
      body: CalendarPage(), // Replace Calender with CalendarPage
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  // Map to store dummy events for specific dates
  Map<DateTime, String> _dummyEvents = {
    DateTime(2024, 4, 28): 'Leg Surgery',
    DateTime(2024, 5, 5): 'New Prescription',
    DateTime(2024, 5, 8): 'Discharge',
  };

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? event = _dummyEvents[_selectedDate];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Selected Date:',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        if (event != null)
          Text(
            'Event: $event', // Display the event if there's one for the selected date
            style: TextStyle(fontSize: 20),
          ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _selectDate(_selectedDate.subtract(Duration(days: 1)));
              },
            ),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    _selectDate(selectedDate);
                  }
                });
              },
              child: Text('Select Date'),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                _selectDate(_selectedDate.add(Duration(days: 1)));
              },
            ),
          ],
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalendarPage(),
  ));
}
