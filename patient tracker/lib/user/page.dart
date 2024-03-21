import 'package:flutter/material.dart';
import 'package:practice/user/patient.dart'; // for Patient Information Page
//import 'package:practice/user/patient.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font

class Page_User extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<Page_User> createState() => _Page();
}

class _Page extends State<Page_User> {
  /*
  final GlobalKey _actionKey = GlobalKey();
  OverlayEntry? _menuOverlayEntry;

  void logoutButton(){
    final renderBox = _actionKey.currentContext?.findRenderObject() as RenderBox;
    const menuWidth = 200.0;
    
    // overlay to show the menu
    _menuOverlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          // set clear background
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeMenu,
              child: Container(color: Colors.transparent),
            )
          ),
          // the widget to show the menu
          Positioned(
            left: MediaQuery.of(context).size.width - menuWidth - 24,
            top: renderBox.size.height / 2,
            width: menuWidth,
            child: AccountMenu(
              onClose: _closeMenu,
            ),
          ),
        ],
      );
    });
    // show the menu
    Overlay.of(context).insert(_menuOverlayEntry!);
  }
  

  void _closeMenu(){
    // close the menu
    _menuOverlayEntry?.remove();
    _menuOverlayEntry = null;
  }
  */

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
          //iconSize: 70,
          onPressed: (){
            //
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Color(0xFF373C88),
              size: 40
            ),
            onPressed: (){
              //Navigator.pop(context);
              //logoutButton(),
            },
          ),
          SizedBox(width: 10),
        ],     
        backgroundColor: Color(0xFFF4F4F4),
      ),
      body: add_patient(),
    );
  }
}
