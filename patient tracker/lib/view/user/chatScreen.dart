import 'package:flutter/material.dart';
import 'package:practice/view/user/home.dart';
import 'package:practice/view/user/patientDisplay.dart';  // to access the patientList
import 'package:practice/main.dart';   // for login page 
import 'package:practice/view/user/chat_page.dart'; 
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial
import 'package:socket_io_client/socket_io_client.dart' as IO; // for socket IO


class chatScreenPage extends StatefulWidget {
  //const MyWidget({super.key});
  final listData sendListData;
  chatScreenPage(this.sendListData); // store the patientList[index] data

  @override
  State<chatScreenPage> createState() => _chatScreenPage(sendListData);
}

class messageList{
  String mes;
  bool isYourMes;

  messageList(
    this.mes,
    this.isYourMes,
  );  
}

List<messageList> messList = [];

class _chatScreenPage extends State<chatScreenPage> {
//class chatPage extends StatelessWidget {
  final listData sendListData;
  _chatScreenPage(this.sendListData); // store the patientList[index] data

  /* chat message */
  TextEditingController staff_message = TextEditingController();
  String text_message = '';
  bool isStaffMes = true;
  late final IO.Socket socket;

  void sendMessage() {
    socket.emit('send-message',{
      'body':staff_message.text,
    });
  }

  
  /* start connection */
  @override
  void initState(){
    /*
    messList.add(
      messageList('Hello', true)
    );
    messList.add(
      messageList('Hey', false)
    );
    messList.add(
      messageList('Hello', true)
    );
    messList.add(
      messageList('Hey', false)
    );
    */

    super.initState();

    socket = IO.io(
      "http://localhost:3000",
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build()
    );
    
    /* Success Connection */
    socket.connect();   // connect with server
    socket.onConnect((_) {
      // execute if connect ??
      debugPrint('connect');
    });

    /* error case */
    socket.onDisconnect((_) => print('Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));

    /* get event from the server */
    socket.on('getMessageEvent',(newMessage){
      //messageList.add(MessageModel.fromJson(data));
      debugPrint('$newMessage');
    });

  }

  /* send messages to the server */
  void sendMessage_staff() {
    socket.emit('sendMessageEvent', 'Hello');
  }

  /* stop the connection  */
  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
  

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
              MaterialPageRoute(builder: (context) => Page_User()), // go to user's pages
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
      body: SafeArea(
        child: Container(
          //width: 600,
          alignment: Alignment.center,          
          margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: messList.length,//messList.length,                      
                    itemBuilder: (context, index){
                      final isLeftAligned = messList[index].isYourMes;
                      return Container(
                        child: Column(
                          crossAxisAlignment: isLeftAligned ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                          children: [
                            Text(
                              '2:43 PM',
                              style: TextStyle(
                                color: Color(0xFF666565),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container ( 
                              constraints: BoxConstraints(maxWidth: 200),
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 5), 
                              padding: EdgeInsets.all(10),                              
                              decoration: ShapeDecoration(
                                color: isLeftAligned ? Color(0xFF373C88) : Color(0xFFF4F4F4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              child: Text(
                                //'Hello\nsfasf',
                                '${messList[index].mes}',
                                style: TextStyle(
                                  color: isLeftAligned ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ), 
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: ShapeDecoration(
                  color: Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [                    
                    Text(
                      'Chat',
                      style: TextStyle(
                        color: Color(0xFF373C88),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: staff_message,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter message...'
                            ),
                            onChanged: (String? value) {
                              setState(() {
                              text_message = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          onPressed: (){
                            sendMessage();
                            setState((){  
                              /*                            
                              messList.add(
                                messageList(text_message, isStaffMes)
                              );
                              */                              
                              messList.insert(
                                0, messageList(text_message, isStaffMes)
                              );
                              isStaffMes = !isStaffMes;
                              staff_message.clear();
                              text_message = '';
                            });
                          }, 
                          icon: Icon(
                            Icons.send,
                            color: Color(0xFF373C88),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 120,
                height: 40,                
                child: ElevatedButton(
                  onPressed: (){
                    setState((){
                      sendChatRequest = !sendChatRequest;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => chatPage(sendListData)), // go to patient home pages
                    );                    
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF373C88),
                    foregroundColor: Colors.white, 
                  ),
                  child: Text(
                    'Exit Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



