import 'package:flutter/material.dart';
import 'package:practice/main.dart';   // for login page 
import 'package:practice/user/patient.dart';  // to access the patientList
import 'package:practice/user/patientInfo.dart'; // go to patientInfo page
import 'package:practice/user/chat_page.dart'; // go to pharmacy page
import 'package:practice/user/pharmacy_page.dart';  // go to vitals page
import 'package:practice/user/calender_page.dart'; // go to calender page
import 'package:practice/user/notification_page.dart'; // go to notification page
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial
import 'dart:math';
/*
class vitalsPage extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<vitalsPage> createState() => _vitalsPage();
}
*/

//class _vitalsPage extends State<vitalsPage> {
class vitalsPage extends StatelessWidget {
  final listData sendListData;
  vitalsPage(this.sendListData); // store the patientList[index] data

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
        icon: Icons.thermostat_auto_outlined,  // vitals icon
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
                MaterialPageRoute(builder: (context) => pharmacyPage(sendListData)), // go to vitals page
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
      body: Vitals(),
    );
  }
}

class Vitals extends StatelessWidget {
  //const requestChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Vitals',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              
            ),
          ),
          SizedBox(height: 20),
          HeartbeatAnimation(), // Display HeartbeatAnimation widget
        ],
      ),
    );
  }
}
class ListData {
  final String name;
  final int age;
  final String condition;

  ListData({
    required this.name,
    required this.age,
    required this.condition,
  });
}
class HeartbeatAnimation extends StatefulWidget {
  @override
  _HeartbeatAnimationState createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: CustomPaint(
            size: Size(200, 200),
            painter: HeartbeatPainter(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HeartbeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    final Path path = Path();
    // Start from the bottom of the heart stem
    path.moveTo(width / 2, height * 0.75);
    // Left lobe of the heart
    path.cubicTo(width * 0.1, height * 0.3, width * 0.2, height * 0.1, width / 2, height * 0.3);
    // Right lobe of the heart
    path.cubicTo(width * 0.8, height * 0.1, width * 0.9, height * 0.3, width / 2, height * 0.75);
    // Closing the path to form a full and rounded top part
    path.close();

    canvas.drawPath(path, paint);

    // Text style for '76bpm'
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,  // Adjust the font size as needed
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: '76bpm',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    // Positioning the text at the center of the canvas, slightly above the middle
    final offset = Offset((width - textPainter.width) / 2, (height * 0.4) - (textPainter.height / 2));  // Adjust the vertical position
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class HeartbeatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heartbeat Animation'),
      ),
      body: Center(
        child: HeartbeatAnimation(),
      ),
    );
  }
}

