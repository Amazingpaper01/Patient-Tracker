import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/view/user/patientInfo.dart'; // for patient Home 
import 'package:practice/view/user/patient_list.dart'; // for initial message to the list
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON
import 'dart:async';
import 'package:practice/model/patient.dart';  // fromJSON

/* Class for List of Patient Data */
class listData {
  String fName;  // first name
  String lName;  // last name
  int patientID;  // patient ID
  String initial_fName;  // first letter of first name 
  String initial_lName;  // first letter of last name
  bool isFavorite;  // favorite status (true or false)
  int fav;  // favorite status (0 or 1)
  int numIndex; // index number
  int favIndex; // index number of favorite list

  String gender;
  String bloodType;

  String room;
  String condition;
  String medication;

  DateTime admDate;
  DateTime disDate;
  String doctor;

  listData (
    this.fName, 
    this.lName, 
    this.patientID, 
    this.initial_fName, 
    this.initial_lName, 
    this.isFavorite, 
    this.fav, 
    this.numIndex, 
    this.favIndex,

    this.gender,
    this.bloodType,
    this.room,
    this.condition,
    this.medication,
    this.admDate,
    this.disDate,
    this.doctor,
  );
}


class add_patient extends StatefulWidget {
  add_patient ({Key? key}) : super(key:key);
  //const MyWidget({super.key});
  @override
  State<add_patient> createState() => _add_patient();
}


/* List for Patient Data */
List<listData> patientList = <listData>[];

/* List for Demo */
/* line 78: index number for Demo */
/*
List<listData> patientList = <listData>[
  listData('Joe', 'Doe', 654321, 'J', 'D', true, 0,0,0),
  listData('John', 'Smith', 234567, 'J', 'S', true, 0,1,0),
];  
*/

  


String _fName2 = ''; //patient.firstName ?? '';
String _lName2 = ''; //patient.lastName ?? '';
String _init_fName2 = ''; //fName[1];
String _init_lName2 = ''; //lName[1];
String _dName2 = ''; //patient.doctorName ?? '';
int _patientID2 = 0;
String _gender2 = '';
String _bloodType2 = '';
String _room2 = '';
String _condition2 = '';
String _medication2 = '';
DateTime _admDate2 = DateTime.now();
DateTime _disDate2 = DateTime(0000,0,0,00,00,00);



class _add_patient extends State<add_patient> {
  List<Patient> patientInfo = <Patient>[];
  /* API */
  final String apiURL = 'https://projpatienttracker.azurewebsites.net/auth/addpatient'; // backend URL
  String result = ''; // to store the result from the API call

  /* ======================== */
  /* applying POST request */
  void postRequest_addPatient() async {
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'patientID': send_patientID,
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
        _fName2 = patient.firstName ?? '';
        _lName2 = patient.lastName ?? '';
        _init_fName2 = _fName2[0];
        _init_lName2 = _lName2[0];
        _patientID2 = patient.patientID ?? 0;
        _dName2 = patient.doctorName ?? '';
        _gender2 = patient.gender ?? '';
        _bloodType2 = patient.bloodtype ?? '';
        _room2  = patient.roomNum ?? '';
        _condition2 = patient.condition ?? '';
        _medication2  = patient.medications ?? '';
        _admDate2 = patient.admissionDate ?? DateTime.now();
        _disDate2 = patient.dischargeDate ?? DateTime(0000,0,00,00,00,00);
      });

      
      //print(patient);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        /* Successful POST request, handle the reponse here */    
        setState((){
          patientInfo.add(patient);
        });
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
  final String apiURL_profile2 = 'http://129.8.213.164:3000/auth/patientProfile'; // backend URL
  String getResult = ''; // to store the result from the API call

  /* applying GET request */
  void postRequest_profile2(int num) async {
    try {
      final response = await http.post(
        Uri.parse(apiURL_profile2),
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


  /* create Controller */
  final TextEditingController patient_fname = TextEditingController();
  final TextEditingController patient_lname = TextEditingController();
  final TextEditingController patient_ID = TextEditingController();  

  /* delete patient data from textfield */
  deleteTextData(){
    patient_fname.clear();
    patient_lname.clear();
    patient_ID.clear();
  }
  
  /* Manage Messages */
  createList(){
    if (patientList.length == 0){
      return patient_list();
    }        
    else {
      return not_EmptyList();
    }      
  }
  
  /* Patient Data */
  String text_fname = '';  // first name
  String text_lname = '';  // last name
  int text_patientID = 0;  // patient ID
  int send_patientID = 0;  
  String text_initial_fname = '';  // initial first name
  String text_initial_lname = '';  // initial last name

  /* Favorite Button */
  bool _isFavorite = true;  // for favorite button codition (true or false)
  int _fav = 0;  // for favorite button condition (0 or 1)
  int _numIndex = 0; // index number 
  /*int _numIndex = 2; // index number for DEMO */
  int _favIndex = 0; // index number of favorite list


  final formKey = GlobalKey<FormState>();

  /* showDialog to create the new list of the patient */
  Future<void> InputDialog(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Container( 
              child: Row(
                children: [
                  Text(
                    'Add Patient',
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
                  /* Patient ID */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: patient_ID,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Patient ID',
                        hintText: '6-digit code...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          send_patientID = int.parse(value);  // convert string to int
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
                            if (formKey.currentState!.validate()){
                              postRequest_addPatient();
                              deleteTextData();  // delete textfield data
                              
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pop();
                                _secondDialog2(context);
                              });
                              
                              /*
                              setState(() {
                                patientList.add(listData(text_fname, text_lname, text_patientID, text_initial_fname, text_initial_lname, _isFavorite, _fav, _numIndex, _favIndex));  // add elements to the list
                                _numIndex++;
                                debugPrint(_numIndex.toString());
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

  Future<void> _secondDialog2(BuildContext context) async {
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
                                          /* Question */
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
                                                  '${_fName2}, ${_lName2}',
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
                                                  '${_patientID2}',
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
                                                    setState(() {                                                      
                                                      _numIndex++;
                                                      debugPrint(_numIndex.toString());
                                                    });
                                                    //postRequest_addPatient();
                                                    Navigator.of(context).pop();
                                                    
                                                    patientList.add(
                                                      listData(
                                                        _fName2, 
                                                        _lName2, 
                                                        _patientID2, 
                                                        _init_fName2, 
                                                        _init_lName2, 
                                                        _isFavorite, 
                                                        _fav, 
                                                        _numIndex, 
                                                        _favIndex,

                                                        _gender2,
                                                        _bloodType2, 
                                                        _room2, 
                                                        _condition2, 
                                                        _medication2, 
                                                        _admDate2, 
                                                        _disDate2,
                                                        _dName2
                                                      )
                                                    );
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
                /* Confirm */
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
                            patientList.removeAt(index); // delete the selected list
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
                    itemCount: patientList.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => patientHome(patientList[index])), // go to user's pages
                          ); 
                          //getRequest();   
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
                                /* favorite button */
                                IconButton(
                                  onPressed: (){
                                    setState(() {                                    
                                      patientList[index].isFavorite = !patientList[index].isFavorite;  // flip the favorite button status
                                      if(patientList[index].isFavorite == false){
                                        patientList[index].fav = 1;
                                        int num1 = _favIndex++;
                                        patientList[index].favIndex = num1;
                                        /* sort the list */
                                        patientList.sort((a,b) {
                                          if((a.isFavorite && b.isFavorite) == false){
                                            /* sort lists among favorite  */
                                            return a.favIndex.compareTo(b.favIndex);
                                          }
                                          /* sort lists among not favorite  */
                                           return a.numIndex.compareTo(b.numIndex);
                                        });
                                      }
                                      else {
                                        patientList[index].fav = 0;
                                        patientList[index].favIndex = 0;
                                        /* sort the list */
                                        patientList.sort((a,b) {
                                          if((a.isFavorite && b.isFavorite) == false){
                                            /* sort lists among favorite  */
                                            return a.favIndex.compareTo(b.favIndex);
                                          }
                                          /* sort lists among non-favorite  */
                                           return a.numIndex.compareTo(b.numIndex);
                                        });                                   
                                      }
                                      /* sorted by favorite and non-favorite */
                                      patientList.sort((a, b) => b.fav.compareTo(a.fav));
                                    });
                                  }, 
                                  icon: Icon(
                                    patientList[index].isFavorite ? Icons.favorite_outline_outlined : Icons.favorite,
                                    color: patientList[index].isFavorite ? null: Color(0xFFD00202),//Color(0xffff0000)
                                  ),
                                ),
                                SizedBox(width: 10),
                                /* Profile Icon */
                                CircleAvatar(
                                  backgroundColor: Color(0xFF373C88),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      /* First Name Initial */
                                      Text(
                                        patientList[index].initial_fName,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      /* Last Name Initial */
                                      Text(
                                        patientList[index].initial_lName,
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
                                  patientList[index].fName,
                                  style: GoogleFonts.roboto(
                                    color: Color(0xFF373C88),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                /* Last Name */
                                Text(
                                  patientList[index].lName,
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
                              'Dr. ${patientList[index].doctor}',
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
                    InputDialog(context);  // show the dialog to create the list     
                  },  
                  child: SizedBox(
                    width: 143,
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
                          'Add New Patient',
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
              ],
            ),
          ]
        ),
      ),
    );
  }
}

