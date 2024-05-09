import 'package:flutter/material.dart';
import 'package:practice/main.dart';   // for login page 
import 'package:practice/view/user/patientDisplay.dart';  // to access the patientList
import 'package:practice/view/user/patientInfo.dart'; // go to patientInfo page
import 'package:practice/view/user/chat_page.dart'; // go to pharmacy page
import 'package:practice/view/user/pharmacy_page.dart';  // go to vitals page
import 'package:practice/view/user/calender_page.dart'; // go to calender page
import 'package:practice/view/user/notification_page.dart'; // go to notification page
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              children: [
                _buildVitalWidget(
                  label: 'Heart rate:',
                  animation: HeartbeatAnimation(),
                ),
                SizedBox(height: 20),
                _buildVitalWidget(
                  label: 'Respiration rate:',
                  animation: BreathingAnimation(),
                ),
                SizedBox(height: 20),
                _buildVitalWidget(
                  label: 'Temperature:',
                  animation: ThermometerAnimation(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalWidget({required String label, required Widget animation}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        animation,
        Divider(),
      ],
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
        title: Text('Heartbeat Animation2'),
      ),
      body: Center(
        child: HeartbeatAnimation(),
      ),
    );
  }
}
//sdfhklsadjfhsdajklfnsdkjlcjsdklacnlskj
class BreathingAnimation extends StatefulWidget {
  @override
  _BreathingAnimationState createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
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
            painter: BreathingPainter(),
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

class BreathingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    // Define the amount of downward translation (adjust as needed)
    final double translateY = height * 0.2; // 20% of canvas height

    // Adjusted trachea to connect the lungs at the top
    final double tracheaWidth = width * 0.5;
    final double tracheaHeight = height * 0.09;
    final double tracheaTop = height * 0.05 + translateY;

    // Define trachea path
    final Path tracheaPath = Path();
    tracheaPath.moveTo((width - tracheaWidth) / 2, tracheaTop);
    tracheaPath.lineTo((width + tracheaWidth) / 2, tracheaTop);
    tracheaPath.lineTo((width + tracheaWidth) / 2, tracheaTop + tracheaHeight);
    tracheaPath.lineTo((width - tracheaWidth) / 2, tracheaTop + tracheaHeight);
    tracheaPath.close();

    // Save the canvas state before drawing
    canvas.save();

    // Translate the canvas downwards
    canvas.translate(0, translateY);

    // Calculate rotation transformation for the trachea (90 degrees clockwise)
    final double tracheaCenterX = width / 2;
    final double tracheaCenterY = tracheaTop + (tracheaHeight / 2);
    canvas.translate(tracheaCenterX, tracheaCenterY);
    canvas.rotate(-pi / 2); // Rotate by -90 degrees (clockwise)
    canvas.translate(-tracheaCenterX, -tracheaCenterY);

    // Draw trachea with the rotated transformation
    canvas.drawPath(tracheaPath, paint);

    // Restore the canvas state after drawing
    canvas.restore();

    // Draw tubes connecting trachea to lungs
    final Path leftTubePath = Path();
    final Path rightTubePath = Path();

    // Starting point for left and right tubes
    final double tubeStartX = width / 2;
    final double tubeStartY = tracheaTop + (tracheaHeight / 2);

    // Ending point for left and right tubes
    final double tubeEndY = height * 0.6 + translateY;

    // Control point for left and right tubes
    final double controlPointX = width * 0.35;

    // Define left tube path
    leftTubePath.moveTo(tubeStartX, tubeStartY);
    leftTubePath.quadraticBezierTo(controlPointX, tubeEndY, width * 0.3, height * 0.5 + translateY);
    leftTubePath.close();

    // Define right tube path
    rightTubePath.moveTo(tubeStartX, tubeStartY);
    rightTubePath.quadraticBezierTo(width - controlPointX, tubeEndY, width * 0.7, height * 0.5 + translateY);
    rightTubePath.close();

    // Draw left and right tubes
    canvas.drawPath(leftTubePath, paint);
    canvas.drawPath(rightTubePath, paint);

    // Adjusted drawing for closer lungs
    final Path leftLungPath = Path();
    leftLungPath.moveTo(width * 0.3, height * 0.65 + translateY); // Adjusted to prevent cutoff
    leftLungPath.quadraticBezierTo(width * 0.2, height * 0.5 + translateY, width * 0.3, height * 0.25 + translateY);
    leftLungPath.quadraticBezierTo(width * 0.5, height * 0.35 + translateY, width * 0.4, height * 0.65 + translateY);
    leftLungPath.close();

    final Path rightLungPath = Path();
    rightLungPath.moveTo(width * 0.7, height * 0.65 + translateY); // Adjusted to prevent cutoff
    rightLungPath.quadraticBezierTo(width * 0.8, height * 0.5 + translateY, width * 0.7, height * 0.25 + translateY);
    rightLungPath.quadraticBezierTo(width * 0.5, height * 0.35 + translateY, width * 0.6, height * 0.65 + translateY);
    rightLungPath.close();

    // Draw the lungs
    canvas.drawPath(leftLungPath, paint);
    canvas.drawPath(rightLungPath, paint);

    // Text style for '20rpm'
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: '20rpm',
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

    // Position the text at the bottom of the canvas
    final double textYPosition = height * 0.7 + translateY; // Adjusted to be below the lungs
    final offset = Offset((width - textPainter.width) / 2, textYPosition);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
class ThermometerAnimation extends StatefulWidget {
  @override
  _ThermometerAnimationState createState() => _ThermometerAnimationState();
}

class _ThermometerAnimationState extends State<ThermometerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fluidAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Adjust duration as needed
    );

    _fluidAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: ThermometerPainter(fluidLevel: _fluidAnimation.value),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ThermometerPainter extends CustomPainter {
  final double fluidLevel; // Value between 0 and 1 to represent the fluid level
  ThermometerPainter({required this.fluidLevel}); // Constructor with fluidLevel parameter

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final Paint blackPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Paint redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Draw the thermometer tube (black)
    final double tubeWidth = width * 0.2;
    final double tubeHeight = height * 0.8;
    final double tubeTop = height * 0.1;
    final double tubeLeft = (width - tubeWidth) / 2;

    final Rect tubeRect = Rect.fromLTWH(tubeLeft, tubeTop, tubeWidth, tubeHeight);
    canvas.drawRect(tubeRect, blackPaint);

    // Calculate the maximum fluid height (85% of the way to the top)
    final double maxFluidHeight = tubeHeight * 0.85;

    // Draw the red fluid
    final double fluidWidth = width * 0.2;
    final double fluidHeight = maxFluidHeight * fluidLevel;
    final double fluidTop = tubeTop + tubeHeight - fluidHeight;
    final double fluidLeft = (width - fluidWidth) / 2;

    final Rect fluidRect = Rect.fromLTWH(fluidLeft, fluidTop, fluidWidth, fluidHeight);
    canvas.drawRect(fluidRect, redPaint);

    // Draw lines for measuring
    final double lineSpacing = maxFluidHeight / 5; // Adjust as needed
    final double lineWidth = fluidWidth * 0.75;
    final double lineStartX = (width - lineWidth) / 2;
    final double lineEndX = lineStartX + lineWidth;

    for (int i = 0; i < 6; i++) {
      final double lineY = tubeTop + (i * lineSpacing);
      final Offset start = Offset(lineStartX, lineY);
      final Offset end = Offset(lineEndX, lineY);
      canvas.drawLine(start, end, blackPaint);
    }

    // Draw temperature text
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: '101°F',
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

    // Position the text at the bottom of the canvas with some spacing
    final double textYPosition = height * 0.95; // Adjusted to be at the bottom
    final offset = Offset((width - textPainter.width) / 2, textYPosition - 10); // Adjusted the spacing
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}