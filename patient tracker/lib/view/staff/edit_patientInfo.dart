import 'package:flutter/material.dart';
import 'package:practice/main.dart';    // go back login page
import 'package:practice/view/staff/patientDisplay.dart'; // to access the patientList
import 'package:practice/view/staff/patientInfo.dart'; // to access the patietInfo
import 'package:practice/view/staff/patientDisplay.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // for using SpeedDial
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'package:flutter/material.dart'; // for radio button


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
class patientHome_edit extends StatelessWidget {
//class _patientHome extends State<patientHome> {
  final listData1 sendListData;
  final int indexNum;
  patientHome_edit(this.sendListData, this.indexNum); // store the patientList[index] data

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
      body: editPatientInfo(sendListData, indexNum)
    );
  }
}

/* show Patient Information */
class editPatientInfo extends StatefulWidget {
  //const MyWidget({super.key});
  final listData1 sendListData1;
  final int indexNum;
  editPatientInfo(this.sendListData1, this.indexNum); 

  @override
  State<editPatientInfo> createState() => _editPatientInfo(sendListData1, indexNum);
}

/* Modify the patientInfo */
class _editPatientInfo extends State<editPatientInfo> {
//class editPatientInfo extends StatelessWidget {

  /* API */
  final String apiURL = 'http://10.62.76.132:3000/auth/modifyPatient'; // backend URL
  String result = ''; // to store the result from the API call
  String mes = '';
  /* ======================== */
    /* applying POST request */
  //Future <void> postRequest() async {
  void postRequest_modifyPatiend() async {
    print("test");
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName': new_fname,
          'lastName': new_lname,
          'gender': new_gender,
          'bloodtype': new_bloodType,
          'doctorName': new_dname,
          'condition': new_condition,
          'roomNum': new_room,
          'medications': new_medication,
          'dischargeDate': new_dischargeDate,
          'patientID': original_patientID
        }),
      );
      final responseData = jsonDecode(response.body);
      final resultString = jsonEncode(responseData);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        /* Successful POST request, handle the reponse here */    
        setState((){
          //result = 'Email: ${responseData['email']}\nPassword: ${responseData['password']}';
          result = resultString;
          print(resultString);   
          //result = resultString;
        });
      }
      else {
        /* if the server returns an error response, thrown an exception */
        //throw Exception('Failed to post data');
        print(resultString);
      }
    }
    catch (e) {
      setState((){
        result = 'Error: $e';
        print(result);
      });
    }
  }
  /* ======================== */
  //const MyWidget({super.key});
  final listData1 sendListData1;
  final int indexNum;
  _editPatientInfo(this.sendListData1, this.indexNum);  // store the patientList[index] data

  //String name = sendListData1.fName;

  final formKey3 = GlobalKey<FormState>();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController dnameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController  medicationController = TextEditingController();
  TextEditingController  dischargeDateController = TextEditingController();

  String? selectedBloodType;
  String? selectedItem;

  String new_fname = '';
  String new_lname = '';
  String new_dname = '';
  String new_room = '';
  String new_gender = '';
  String new_bloodType = '';
  String new_condition = '';
  String new_medication = '';
  String new_dischargeDate = '';

  String original_fname = '';
  String original_lname = '';
  String original_dname = '';
  String original_room = '';
  String original_gender = '';
  String original_bloodType = '';
  String original_condition = '';
  String original_medication = '';
  String original_dischargeDate = '';
  int original_patientID = 0;

  
  //_editPatientInfo(this.sendListData1) 
  //: controller = TextEditingController(text: sendListData1.fName),

  /* API */
  //final String apiURL = 'http://10.62.77.52:3000/auth/login'; // backend URL
  @override

  void initState() {
    super.initState();
    fnameController = new TextEditingController(text: sendListData1.fName);
    lnameController = new TextEditingController(text: sendListData1.lName);
    dnameController = new TextEditingController(text: sendListData1.doctorName);
    roomController = new TextEditingController(text: sendListData1.room);
    conditionController = new TextEditingController(text: sendListData1.condition);
    medicationController = new TextEditingController(text: sendListData1.medication);
    dischargeDateController = new TextEditingController(text: 'N/A');
    selectedItem = sendListData1.gender;
    selectedBloodType = sendListData1.bloodType;
    original_fname = sendListData1.fName;
    original_lname = sendListData1.lName;
    original_dname = sendListData1.doctorName;
    original_room = sendListData1.room;
    original_gender = sendListData1.gender;
    original_bloodType = sendListData1.bloodType;
    original_condition = sendListData1.condition;
    original_medication = sendListData1.medication;

    original_patientID = sendListData1.patientID;
  }
  
  Widget build(BuildContext context) {
    return 
    Form(
      key: formKey3,
      child: Container(
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
                                '${sendListData1.initial_fName}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              /* Initial Last Name */
                              Text(
                                '${sendListData1.initial_lName}',
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
                          '${sendListData1.fName}',
                          style: GoogleFonts.roboto(
                            color: Color(0xFF373C88),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        /* Last Name */
                        Text(
                          '${sendListData1.lName}',
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
                      'Doctor: ${sendListData1.doctorName}',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF373C88),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  
                
                  /* Modify the patient and doctor name */
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [

                        /* First Name */
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            children: [                              
                              Text(
                                'First Name: ',
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF49454F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              /* Patient First Name */
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: fnameController,
                                  onTap: (){
                                    formKey3.currentState!.save();
                                  },
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_fname = value;
                                      sendListData1.fName = new_fname;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* Last Name */
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            children: [                              
                              Text(
                                'Last Name: ',
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF49454F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              /* Patient First Name */
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: lnameController,
                                  onTap: (){
                                    formKey3.currentState!.save();
                                  },
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_lname = value;
                                      sendListData1.lName = new_lname;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* Doctor Name */
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            children: [                              
                              Text(
                                'Doctor Name: ',
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF49454F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              /* Patient First Name */
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: lnameController,
                                  onTap: (){
                                    formKey3.currentState!.save();
                                  },
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_dname = value;
                                      sendListData1.doctorName = new_dname;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
                                '',
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
                              SizedBox(width: 10),
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: roomController,
                                  onTap: (){
                                    formKey3.currentState!.save();
                                  },
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_room = value;
                                      sendListData1.room = new_room;
                                    });
                                  },
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
                              SizedBox(width: 10),
                              Container(
                                width: 170,
                                child: DropdownButtonFormField(
                                  hint: Text('Select choice...'),
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text('Male'),
                                      value: 'Male',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Female'),
                                      value: 'Female',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Nonbinary'),
                                      value: 'Nonbinary',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Other'),
                                      value: 'Other',
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedItem = value!;
                                      new_gender = value;
                                      sendListData1.gender = value;
                                    });
                                  },
                                  value: selectedItem,                              
                                  dropdownColor: Color(0xFFF5F5F5),
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    border: OutlineInputBorder(),
                                  ),
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
                              Container(
                                width: 170,
                                child: DropdownButtonFormField(
                                  hint: Text('Select here...'),
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text('A+'),
                                      value: 'A+',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('A-'),
                                      value: 'A-',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('B+'),
                                      value: 'B+',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('B-'),
                                      value: 'B-',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('O+'),
                                      value: 'O+',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('O-'),
                                      value: 'O-',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('AB+'),
                                      value: 'AB+',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('AB-'),
                                      value: 'AB-',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Unknown'),
                                      value: 'unknown',
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedBloodType = value!;
                                      new_bloodType = value;
                                      sendListData1.bloodType = value;
                                    });
                                  },
                                  value: selectedBloodType,
                                  dropdownColor: Color(0xFFF5F5F5),
                                  decoration: InputDecoration(
                                    labelText: 'Blood Type',
                                    border: OutlineInputBorder(),
                                  ),
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
                              /*
                              Text(
                                '${sendListData1.condition}',
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF49454F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              */
                              SizedBox(width: 10),
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: conditionController,
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_condition = value;
                                      sendListData1.condition = new_condition;
                                    });
                                  },
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
                              SizedBox(width: 10),
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: medicationController,
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_medication = value;
                                      sendListData1.medication = new_medication;
                                    });
                                  },
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
                                '',
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
                              SizedBox(width: 10),
                              Container(
                                width: 170,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                color: Color(0xFFF4F4F4),
                                child: TextFormField(
                                  controller: dischargeDateController,
                                  onChanged: (String value){
                                    setState(() {
                                      //text_doctor_name = value;
                                      new_dischargeDate = value;
                                      //sendListData1.dischargeDate = new_dischargeDate;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* cancel button */
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, 
                            foregroundColor: Color(0xFF373C88),
                            side: BorderSide(
                              color: Color(0xFF373C88)
                            ),
                          ),
                          onPressed: (){                            
                            Navigator.pop(context);
                            setState((){
                              roomController.clear();
                              conditionController.clear();
                              medicationController.clear();
                              selectedItem = null;
                              selectedBloodType = null;
                              /* return the data to original data */
                              sendListData1.fName = original_fname;
                              sendListData1.lName = original_lname;
                              sendListData1.room = original_room;
                              sendListData1.gender = original_gender;
                              sendListData1.condition = original_condition;
                              sendListData1.medication = original_medication;
                            });
                          }, 
                          child: 
                          SizedBox(
                            width: 50,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [                  
                                Text(
                                    'Cancel',
                                    style: TextStyle(
                                    color: Color(0xFF373C88),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        /* Save button */
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF373C88),
                            foregroundColor: Colors.white, 
                          ),
                          onPressed: (){
                            setState((){
                              /* make null data (only for selection types) */
                              selectedItem = null;
                              selectedBloodType = null;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => patientHome(sendListData1, indexNum)), // go to user's pages
                            );
                            postRequest_modifyPatiend();
                          }, 
                          child: SizedBox(
                            width: 50,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [                  
                                Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ]
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],      
        ),
      ),
    );
  }
}
