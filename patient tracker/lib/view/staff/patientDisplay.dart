import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/main.dart';
import 'package:practice/model/patient.dart';  
import 'package:practice/view/staff/patientInfo.dart'; // for patient Home 
import 'package:practice/view/staff/patient_list.dart'; // for initial message to the list
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'package:intl/intl.dart'; // for DateTime format
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/view/user/patientDisplay.dart'; // for riverpod



/* Class for List of Patient Data */
class listData1 {
  String fName;  // first name
  String lName;  // last name  
  String initial_fName;  // first letter of first name 
  String initial_lName;  // first letter of last name
  String doctorName;
  int patientID;

  String gender;
  String bloodType;

  String room;
  String condition;
  String medication;

  DateTime admDate;
  DateTime disDate;

  listData1 (
    this.fName, 
    this.lName, 
    this.initial_fName, 
    this.initial_lName, 
    this.doctorName, 
    this.patientID,
    
    this.gender,
    this.bloodType,
    this.room,
    this.condition,
    this.medication,
    this.admDate,
    this.disDate,
  );
}

/* List for Patient Data */
//final _patientList1 = StateProvider<List<listData1>>((ref) => []);
List<listData1> patientList1 = <listData1>[]; 


//List<Patient> patientInfo = <Patient>[];
//List<Patient> confirmPatient = <Patient>[];

/* List for Patient Data */
String post_fName = '';
String post_lName = '';
String post_init_fName = post_fName[0];
String post_init_lName = post_lName[0];
String post_gender = '';
String post_bloodType = '';
String post_dName = '';
String post_condition = '';
String post_room = '';
String post_medi = '';
DateTime post_addDate = DateTime.now();
DateTime post_disDate = DateTime.now();
int post_id = 0;

String _fName = ''; //patient.firstName ?? '';
String _lName = ''; //patient.lastName ?? '';
String _init_fName = ''; //fName[1];
String _init_lName = ''; //lName[1];
String _dName = ''; //patient.doctorName ?? '';
int _patientID = 0;
String _gender = '';
String _bloodType = '';
String _room = '';
String _condition = '';
String _medication = '';
DateTime _admDate = DateTime.now();
DateTime _disDate = DateTime(0000,0,0,00,00,00);

int deleteIndex = 0;
bool isDeleteList = false;

class add_patient extends StatefulWidget {
  add_patient ({Key? key}) : super(key:key);
  void initState(){
    if(isDeleteList){
      patientList1.removeAt(deleteIndex);
      isDeleteList = !isDeleteList;
    }
    Future.delayed(Duration(seconds: 1), () {
    // 1秒後に実行される処理をここに記述します
    });
  }
  
  //const MyWidget({super.key});
  @override
  
  State<add_patient> createState() => _add_patient();
}


class _add_patient extends State<add_patient> {

  

  /* API */
  final String apiURL = 'https://projpatienttracker.azurewebsites.net/auth/createpatient'; // backend URL
  String result = ''; // to store the result from the API call

  String? res_fName;
  String? res_lName ;
  int? res_patientID;

  /* ======================== */
    /* applying POST request */
  void postRequest_createPatiend() async {
  //Future<List<Patient>> postRequest_createPatiend() async {
    // print("test");
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName': send_fname,
          'lastName': send_lname,
          'gender': send_gender,
          'bloodtype': send_blood_type,
          'doctorName': send_doctor_name,
          'condition': send_condition,
          'roomNum': send_room,
          'medications': send_medication,
        }),
      );

      final responseData = jsonDecode(response.body);
      final patient = Patient.fromJson(responseData);
      final resultString = jsonEncode(responseData);
      print('patientID: ${patient.patientID}');   
      //final text_fname2 = patient.firtName ?? '';
      //print(text_fname2);
      print(patient);

      setState((){
        _fName = patient.firstName ?? '';
        _lName = patient.lastName ?? '';
        _init_fName = _fName[1];
        _init_lName = _lName[1];
        _dName = patient.doctorName ?? '';
        _patientID = patient.patientID ?? 0;
        _gender = patient.gender ?? '';
        _bloodType = patient.bloodtype ?? '';
        _room = patient.roomNum ?? '';
        _condition = patient.condition ?? '';
        _medication = patient.medications ?? '';
        _admDate = patient.admissionDate ?? DateTime.now();
        _disDate = patient.dischargeDate ?? DateTime(0000,0,00,00,00,00);
        patientList1.add(listData1(_fName, _lName, _init_fName, _init_lName, _dName, _patientID, _gender, _bloodType, _room, _condition, _medication, _admDate, _disDate));  // add elements to the list
        
      });

      // print(response.statusCode);
      if (response.statusCode == 201) {
        
      }
      else {
        /* if the server returns an error response, thrown an exception */
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
  
  /* API */
  final String apiURL2 = 'https://projpatienttracker.azurewebsites.net/auth/addpatient'; // backend URL
  String result2 = ''; // to store the result from the API call
  String text_patientID_2 = '';
  
  /* ======================== */
  /* applying POST request */
  void postRequest_addPatient2() async {
    try {
      final response = await http.post(
        Uri.parse(apiURL2),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'patientID': send_patientID_2,
        }),
      );
      final responseData = jsonDecode(response.body);
      final patient = Patient.fromJson(responseData);
      //print(patient);
      final resultString = jsonEncode(responseData);

      print('patientID: ${patient.patientID}');   
      //final text_fname2 = patient.firtName ?? '';
      //print(text_fname2);
      print(patient);      
      
      setState((){
        _fName = patient.firstName ?? '';
        _lName = patient.lastName ?? '';
        _init_fName = _fName[0];
        _init_lName = _lName[0];
        _dName = patient.doctorName ?? '';
        _patientID = patient.patientID ?? 0;
        _gender = patient.gender ?? '';
        _bloodType = patient.bloodtype ?? '';
        _room = patient.roomNum ?? '';
        _condition = patient.condition ?? '';
        _medication = patient.medications ?? '';
        _admDate = patient.admissionDate ?? DateTime.now();
        _disDate = patient.dischargeDate ?? DateTime(0000,0,0,00,00,00);
        print(_patientID);
        //patientList1.add(listData1(_fName, _lName, _init_fName, _init_lName, _dName));  // add elements to the list
        //patientInfo.clear();
      });

      

      // print(response.statusCode);
      if (response.statusCode == 201) {
        /* Successful POST request, handle the reponse here */   
        /*
        result2 = resultString;
        print(resultString);
        print('patientID: ${patient.patientID}');  
        print(patient.firtName);
        res_fName = patient.firtName;
        res_lName = patient.lastName;
        res_patientID = patient.patientID;  

        text_fname = res_fName ?? '';
        text_lname = res_lName ?? '';
        text_patientID = res_patientID ?? 0;
        text_initial_fname = res_fName?[0] ?? '';
        text_initial_lname = res_lName?[0] ?? '';  
        */
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
  /* API */
  final String apiURL_profile = 'http://129.8.213.164:3000/auth/patientProfile'; // backend URL
  String getResult = ''; // to store the result from the API call

  /* applying GET request */
  void postRequest_profile(int num) async {
    try {
      final response = await http.post(
        Uri.parse(apiURL_profile),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'patientID': num,
        }),        
      );
      final responseData = jsonDecode(response.body);
      final patient = Patient.fromJson(responseData);
      final resultString = jsonEncode(responseData);


      if (response.statusCode == 201) {
        /* Successful GET request, handle the reponse here */    
        print(responseData);
        
      }
      else {
        /* if the server returns an error response, thrown an exception */
        //throw Exception('Failed to post data');
        print(resultString);
      }
    }
    catch (e) {
      setState((){
        getResult = 'Error: $e';
        print(getResult);
      });
    }
  }
  /* ======================== */
  

  /* patient data list */
  
  void resetTextData(){
    //patient_fname.clear();
    //patient_lname.clear();
    setState((){
      selectedItem = null;
      selectedBloodType = null;
    });
  }
  
  
  /* Manage Messages */
  createList(){
    if (patientList1.length == 0){
      return patient_list();
    }        
    else {
      return not_EmptyList();
    }      
  }
  
  /* Patient Data */
  String text_fname = '';  // first name
  String text_lname = '';  // last name
  String text_initial_fname = '';  // initial first name
  String text_initial_lname = '';  // initial last name
  String text_gender = 'Male'; // gender
  String text_blood_type = 'A+'; // blood type
  String text_doctor_name = ''; // doctor name

  String text_condition = '';
  String text_room = '';
  String text_medication = '';

  /* Send Patient Data */
  String send_fname = '';  // first name
  String send_lname = '';  // last name
  String send_gender = 'Male'; // gender
  String send_blood_type = 'A+'; // blood type
  String send_doctor_name = ''; // doctor name

  String send_condition = '';
  String send_room = '';
  String send_medication = '';

  //String isSelected = 'Male';
  String? selectedItem;
  String? selectedBloodType;

  int text_index = 0;
  int text_patientID = 0;
  //int text_patientID = 0;  // patient ID

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  /* showDialog to create the new list of the patient (1) */  
  Future<void> InputDialog1(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setStateSB,){
          return Form(
            key: formKey1,
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Container( 
                child: Row(
                  children: [
                    Text(
                      'Create Patient',
                      style: TextStyle(
                        color: Color(0xFF373C88),
                      ),
                    ),
                    SizedBox(width: 70),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Color(0xFF373C88),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: Container(
                height: 600,
                width: 200,
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /* First Name */
                          Container(
                            width: 210,
                            child: TextFormField(
                              //controller: patient_fname,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First Name',
                                hintText: 'Enter here...',
                              ),
                              onChanged: (String value){
                                setState(() {
                                  send_fname = value;  // store first name
                                  //text_initial_fname = text_fname[0];  // store initial first name
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Last Name */
                          Container(
                            width: 210,
                            child: TextFormField(
                              //controller: patient_lname,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name',
                                hintText: 'Enter here...',
                              ),
                              onChanged: (String value){
                                setState(() {
                                  send_lname = value;
                                  //text_initial_lname = text_lname[0];
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Gender */
                          Container(
                            width: 210,
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
                                setStateSB(() {
                                  selectedItem = value!;
                                  send_gender = value;
                                });
                              },
                              value: selectedItem,                              
                              dropdownColor: Color(0xFFF5F5F5),
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please select gender';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Blood Type (Selection) */
                          Container(
                            width: 210,
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
                                setStateSB(() {
                                  selectedBloodType = value!;
                                  send_blood_type = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please select blood type';
                                }
                                return null;
                              },
                              value: selectedBloodType,
                              dropdownColor: Color(0xFFF5F5F5),
                              decoration: InputDecoration(
                                labelText: 'Blood Type',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Doctor */
                          Container(
                            width: 210,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Doctor',
                                hintText: 'Enter here...',
                              ),
                              onChanged: (String value){
                                setState(() {
                                  send_doctor_name = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please enter doctor name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Room */
                          Container(
                            width: 210,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Room',
                                hintText: 'Enter here...',
                              ),
                              onChanged: (String value){
                                setState(() {
                                  //text_doctor_name = value;
                                  send_room = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Condition */
                          Container(
                            width: 210,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Condition',
                                hintText: 'Enter here...',
                              ),
                              onChanged: (String value){
                                setState(() {
                                  //text_doctor_name = value;
                                  send_condition = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          /* Medication */
                          Container(
                            width: 210,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Medication',
                                hintText: 'Enter here...',
                              ),
                              onChanged: (String value){
                                setState(() {
                                  //text_doctor_name = value;
                                  send_medication = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(                
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /* Add Button */
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF373C88),
                                    foregroundColor: Colors.white, 
                                  ),
                                  onPressed: () async {
                                    if (formKey1.currentState!.validate()){
                                      postRequest_createPatiend(); // send POST request
                                      resetTextData(); 
                                      Navigator.of(context).pop();  
                                      /*
                                      setState(() {
                                        patientList1.add(listData1(text_fname, text_lname, text_initial_fname, text_initial_lname, text_gender, text_blood_type, text_doctor_name, text_condition, text_room, text_medication, text_patientID, text_index));  // add elements to the list
                                      });  
                                      */                                                         
                                    } 
                                  },
                                  child: SizedBox(
                                    width: 50,
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [                   
                                        Text(
                                          'Save',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),                    
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ), 
          ); 
        } 
      ),
    );
  }

  final TextEditingController patient_ID_2 = TextEditingController();  
  int send_patientID_2 = 0;  // patient ID


  /* delete patient data from textfield */
  deleteTextData(){
    patient_ID_2.clear();
  }

  final formKey3 = GlobalKey<FormState>();

  /* showDialog to create the new list of Exist patient */
  Future<void> InputDialog_addExistPatient(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) {
        return Form(
          key: formKey3,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Container( 
              child: Row(
                children: [
                  Text(
                    'Add Exist Patient',
                    style: TextStyle(
                      color: Color(0xFF373C88),
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Color(0xFF373C88),
                    ),
                    onPressed: (){
                      deleteTextData();  // delete textfield data
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /* Patient ID */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: patient_ID_2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Patient ID',
                        hintText: '6-digit code...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          send_patientID_2 = int.parse(value);  // convert string to int
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter patient ID';
                        }
                        else {
                          /* check 6 digit numbers or not*/
                          if(value.isNotEmpty){
                            if(RegExp(
                              r"^[0-9]{6}$")
                              .hasMatch(value)){
                                return null;
                            }
                            else {
                              return 'Please enter 6-digit numbers';
                            }
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(                
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /* Add Button */
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF373C88),
                            foregroundColor: Colors.white, 
                          ),
                          onPressed: () async {
                            if (formKey3.currentState!.validate()){
                              print('Post before: ${patientList1}');
                              postRequest_addPatient2();
                              print('Post after: ${patientList1}');
                              deleteTextData();  // delete textfield data
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop();
                                _secondDialog(context);
                              });
                            } 
                          },
                          child: SizedBox(
                            width: 50,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [                   
                                Text(
                                  'Add',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),                    
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),    
          ),    
        );
      },
    );
  }

  Future<void> _secondDialog(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) {
      return AlertDialog(
        title: Container( 
          child: Row(
            children: [
              Text(
                'Confirm',
                style: TextStyle(
                  color: Color(0xFF373C88),
                ),
              ),
              SizedBox(width: 90),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Color(0xFF373C88),
                ),
                onPressed: (){
                  deleteTextData();  // delete textfield data
                  Navigator.pop(context);                                              
                },
              ),
            ],
          ),
        ),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: double.infinity),
              /* Confirm */
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(
                  'Are you sure you want to\nadd this patient?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_fName}, ${_lName}',//'${patientInfo.firstName}', //, ${patientInfo.last}',//'${patientInfo[num].firstName}, ${patientInfo[num].lastName}',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),                                             
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Patient ID: ',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${_patientID}',//'${patientInfo.}',//'${patientInfo[num].patientID}',//'${patientInfo.patientID}',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),                                                
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(   
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,             
                    children: [   
                      /* Confirm Button */               
                      ElevatedButton(
                        onPressed: (){
                          setState((){                                              
                            patientList1.add(listData1(_fName, _lName, _init_fName, _init_lName, _dName,_patientID,_gender, _bloodType, _room, _condition, _medication, _admDate, _disDate));  // add elements to the list
                             print(patientList1);
                          });
                          Navigator.of(context).pop();
                        }, 
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF373C88),
                        ),
                      ),
                      SizedBox(width: 30),
                      /* Cancel Button */
                      ElevatedButton(
                        onPressed: (){
                          setState((){
                            _fName = '';
                            _lName = '';
                            _init_fName = '';
                            _init_lName = '';
                            _dName = '';
                          });
                          Navigator.of(context).pop();
                        }, 
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            color: Color(0xFF373C88),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, 
                          foregroundColor: Color(0xFF373C88),
                          side: BorderSide(
                            color: Color(0xFF373C88)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      }
    );
  }
  
  
  /* showDialog to make sure the deletion of the list */
  Future<void> comfirmDeletion(BuildContext context, int index) async {
    return showDialog(    
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: double.infinity),
                /* Question */
                Container(
                  width: 266,
                  height: 58, 
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),              
                  decoration: ShapeDecoration(
                    color: Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                  child: Text(
                    'Are you sure you want to\ndelete this patient?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: Row(   
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,             
                    children: [   
                      /* Yes Button */               
                      ElevatedButton(
                        onPressed: (){
                          setState(() {
                            patientList1.removeAt(index); // delete the selected list
                            Navigator.of(context).pop();
                          });
                        }, 
                        child: Text(
                          'Yes',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD00202),
                        ),
                      ),
                      SizedBox(width: 50),
                      /* No Button */
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: Text(
                          'No',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF373C88),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color.(0xffE5E5E5)
      body: Container(
        width: double.infinity,    
        /* create each list */ 
        child: ListView(
          children: [
            Column(  
              crossAxisAlignment: CrossAxisAlignment.center,      
              children: [
                SizedBox(height: 30), 
                createList(), // create a list based on input data   
                /* List */       
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), 
                    itemCount: patientList1.length, //patientList1.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: () {  
                          postRequest_profile(patientList1[index].patientID);  
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => patientHome([patientList1[index]], index)), // go to user's pages
                          );                                          
                        },
                        child: Card (    
                          margin: EdgeInsets.all(10),
                          color: const Color(0xFFF4F4F4),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color(0xFF373C88), // border color
                              width: 1, // border thickness                              
                            ),   
                            borderRadius: BorderRadius.circular(10)        
                          ),
                          /* Template Design of the List */
                          child: ListTile(      
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10),
                                /* Profile Icon */
                                CircleAvatar(
                                  backgroundColor: Color(0xFF373C88),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      /* First Name Initial */
                                      Text(
                                        '${patientList1[index].initial_fName}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      /* Last Name Initial */
                                      Text(
                                        '${patientList1[index].initial_lName}', //patientList1[index].initial_lName,
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
                                /* First Name */
                                Text(
                                  '${patientList1[index].fName}',//'${patientInfo[index].firstName}',//patientList1[index].fName,
                                  style: GoogleFonts.roboto(
                                    color: Color(0xFF373C88),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                /* Last Name */
                                Text(
                                  '${patientList1[index].lName}',//'${patientInfo[index].lastName}',//patientList1[index].lName,
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
                              'Dr. ${patientList1[index].doctorName}',//${patientInfo[index].doctorName}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFF373C88),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            /* Deletion Button */
                            trailing: IconButton(                          
                              onPressed: () async {
                                comfirmDeletion(context, index); // confirm the deletion of the list
                              }, 
                              icon: Icon(
                                Icons.do_not_disturb_on,
                                color: Color(0xFFD00202),
                              ),
                            ),   
                          ),  
                        ), 
                      //),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),    
                /* Add New Patient Button */                      
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF373C88),
                    foregroundColor: Colors.white
                  ),
                  onPressed: () async {                
                    InputDialog1(context);  // show the dialog to create the list              
                  },  
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [                  
                        Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        SizedBox(width: 8),
                        Text(
                          'Create New Patient',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
                SizedBox(height: 30),    
                /* Add New Patient Button */                      
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, 
                    foregroundColor: Color(0xFF373C88),
                    side: BorderSide(
                      color: Color(0xFF373C88)
                    ),
                  ),
                  onPressed: () async {                
                    InputDialog_addExistPatient(context);  // show the dialog to create the list     
                  },  
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [                  
                        Icon(
                            Icons.person_add,
                            color: Color(0xFF373C88),
                          ),
                        SizedBox(width: 8),
                        Text(
                          'Add Existing Patient',
                          style: TextStyle(
                            color: Color(0xFF373C88),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]
                    ),
                  ),
                ), 
              ],
            ),
          ]
        ),
      ),
    );
  }
}
