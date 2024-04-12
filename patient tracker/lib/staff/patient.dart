import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/main.dart';  
import 'package:practice/staff/patientInfo.dart'; // for patient Home 
import 'package:practice/staff/patient_list.dart'; // for initial message to the list
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:http/http.dart' as http;  // for http
import 'dart:convert';  // for decoding received JSON



/* Class for List of Patient Data */
class listData1 {
  String fName;  // first name
  String lName;  // last name  
  String initial_fName;  // first letter of first name 
  String initial_lName;  // first letter of last name
  String gender; // gender
  String bloodType; // blood type
  String doctorName;

  String condition;
  String room;
  String medication;

  listData1 (this.fName, this.lName, this.initial_fName, this.initial_lName, this.gender, this.bloodType, this.doctorName, 
    this.condition, this.room, this.medication);
}

/* List for Patient Data */
List<listData1> patientList1 = <listData1>[];  

class add_patient extends StatefulWidget {
  add_patient ({Key? key}) : super(key:key);
  //const MyWidget({super.key});
  @override
  State<add_patient> createState() => _add_patient();
}


class _add_patient extends State<add_patient> {
  /* API */
  final String apiURL = 'http://10.62.84.173:3000/auth/addPatient'; // backend URL
  String result = ''; // to store the result from the API call
  
  /* ======================== */
    /* applying POST request */
  //Future <void> postRequest() async {
  void postRequest_createPatiend() async {
    print("test");
    try {
      final response = await http.post(
        Uri.parse(apiURL),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'firstName': text_fname,
          'lastName': text_lname,
          'gender': text_gender,
          'bloodType': text_blood_type,
          'doctorName': text_doctor_name,
          'condition': text_condition,
          'roomNum': text_room,
          'medications': text_medication,
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

  /* create Controller */
  //final TextEditingController patient_fname = TextEditingController();
  //final TextEditingController patient_lname = TextEditingController();

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

  DateTime? _selectedDate;
  final TextEditingController _textEditingController = TextEditingController();
  selectDate(BuildContext context) async {
    final newSelectedDate = await showDatePicker(
      context: context, 
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2040)
    );
    if(newSelectedDate != null){
      _selectedDate = newSelectedDate;
      _textEditingController.text = _selectedDate.toString();
    }
  }
  
  /* Patient Data */
  String text_fname = '';  // first name
  String text_lname = '';  // last name
  String text_initial_fname = '';  // initial first name
  String text_initial_lname = '';  // initial last name
  String text_gender = 'Male'; // gender
  String text_blood_type = ''; // blood type
  String text_doctor_name = ''; // doctor name

  String text_condition = '';
  String text_room = '';
  String text_medication = '';

  //String isSelected = 'Male';
  String? selectedItem;
  String? selectedBloodType;
  String text_blood_type2 = ''; // blood type

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
                                  text_fname = value;  // store first name
                                  text_initial_fname = text_fname[0];  // store initial first name
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
                                  text_lname = value;
                                  text_initial_lname = text_lname[0];
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
                                  text_gender = value;
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
                                  text_blood_type2 = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty){
                                  return 'Please enter doctor name';
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
                          /*
                          SizedBox(height: 20),
                          /* Blood Type (TextField)*/
                          Container(
                            width: 210,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Blood Type',
                                hintText: "Enter here...",
                              ),
                              onChanged: (String value){
                                setState(() {
                                  text_blood_type = value;
                                });
                              },                      
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Please leave empty if you don't know...",
                            style:  TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          */
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
                                  text_doctor_name = value;
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
                                  text_room = value;
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
                                  text_condition = value;
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
                                  text_medication = value;
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
                                      resetTextData(); 
                                      Navigator.of(context).pop();  
                                      setState(() {
                                        patientList1.add(listData1(text_fname, text_lname, text_initial_fname, text_initial_lname, text_gender, text_blood_type2, text_doctor_name, text_condition, text_room, text_medication));  // add elements to the list
                                      });
                                      postRequest_createPatiend(); // send POST request
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
                    itemCount: patientList1.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: () {                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => patientHome(patientList1[index])), // go to user's pages
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
                                        patientList1[index].initial_fName,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      /* Last Name Initial */
                                      Text(
                                        patientList1[index].initial_lName,
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
                                  patientList1[index].fName,
                                  style: GoogleFonts.roboto(
                                    color: Color(0xFF373C88),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                /* Last Name */
                                Text(
                                  patientList1[index].lName,
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
                              'Dr. ${patientList1[index].doctorName}',
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
                          'Create Patient',
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
