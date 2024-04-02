import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/main.dart';  
import 'package:practice/staff/patientInfo.dart'; // for patient Home 
import 'package:practice/staff/patient_list.dart'; // for initial message to the list
import 'package:google_fonts/google_fonts.dart'; // for using Google Font


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
  String admissionDate;
  String room;
  String medication;
  int patientID;  // patient ID

  //bool isFavorite;  // favorite status (true or false)
  //int fav;  // favorite status (0 or 1)
  //int numIndex; // index number
  //int favIndex; // index number of favorite list

  listData1 (this.fName, this.lName, this.initial_fName, this.initial_lName, this.gender, this.bloodType, this.doctorName, 
    this.condition, this.admissionDate, this.room, this.medication, this.patientID);
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
  /* create Controller */
  final TextEditingController patient_fname = TextEditingController();
  final TextEditingController patient_lname = TextEditingController();
  //final TextEditingController patient_ID = TextEditingController();  

  /* patient data list */
  newPatient(){
    patient_fname.clear();
    patient_lname.clear();
    //patient_ID.clear();
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
  String text_blood_type = ''; // blood type
  String text_doctor_name = ''; // doctor name

  String text_condition = '';
  String text_admission_date = '';
  String text_room = '';
  String text_medication = '';
  int text_patientID = 0;

  //String isSelected = 'Male';
  List<String> genderItem = ['Male','Female'];
  String? selectedItem;

  //int text_patientID = 0;  // patient ID

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  /* showDialog to create the new list of the patient (1) */
  /* included: first name, last name, gender, blood type, doctor */
  
  Future<void> InputDialog1(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) 
      => StatefulBuilder(
        builder: (BuildContext context, setStateSB)
        {
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
                  SizedBox(width: 90),
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
            content: 
            /*
            Column(
            children: [
              */
            Container(
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
                      controller: patient_fname,
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
                      controller: patient_lname,
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
                  /* Blood Type */
                  Container(
                    width: 210,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Blood Type',
                        hintText: 'Enter here...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          text_blood_type = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter blood type';
                        }
                        return null;
                      },
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
                          return 'Please enter room';
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
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter condition';
                        }
                        return null;
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
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter medication';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Admission Date */
                  Container(
                    width: 210,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Admission Date',
                        hintText: 'Enter here...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          //text_doctor_name = value;
                          text_admission_date = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter admission date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Patient ID */
                  Container(
                    width: 210,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Patient ID',
                        hintText: '6-digit code...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          text_patientID = int.parse(value);
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

                  /* Patient ID */
                  /*
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
                          text_patientID = int.parse(value);  // convert string to int
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
                  */
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
                              newPatient(); 
                              Navigator.of(context).pop();  
                              setState(() {
                                patientList1.add(listData1(text_fname, text_lname, text_initial_fname, text_initial_lname, text_gender, text_blood_type, text_doctor_name, text_condition, text_admission_date, text_room, text_medication, text_patientID));  // add elements to the list
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
            
            /*
            Text('Hello')
            ]),
            */
          ), 
        ); 
        } 
      ),
    );
  }
  
  /*
  Future<void> InputDialog1(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) 
      => StatefulBuilder(
        builder: (BuildContext context, setStateSB)
        {
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
                  SizedBox(width: 90),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /* Condition */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: patient_fname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Condition',
                        hintText: 'Enter here...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          //text_fname = value;  // store first name
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
                  /* Admission Date */
                  Container(
                    width: 210,
                    child: TextFormField(
                      controller: patient_lname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Admission Date',
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
                          text_blood_type = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter blood type';
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
                        labelText: 'Medication',
                        hintText: 'Enter here...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          text_blood_type = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter medication';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  /* Patient ID */
                  Container(
                    width: 210,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Patient ID',
                        hintText: 'Enter here...',
                      ),
                      onChanged: (String value){
                        setState(() {
                          text_blood_type = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty){
                          return 'Please enter Patient ID';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Container( 
                    width: double.infinity,               
                    child: Row(   
                      mainAxisAlignment: MainAxisAlignment.center,                   
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /* Cancel Button */
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, 
                            foregroundColor: Color(0xFF373C88),
                            side: BorderSide(
                              width: 1,
                              color:Color(0xFF373C88),
                            )
                          ),
                          onPressed: () async {
                            if (formKey1.currentState!.validate()){
                              newPatient(); 
                              Navigator.of(context).pop();  
                              /*                            
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ), // go to patient home pages
                              );
                              */
                              /*
                              setState(() {
                                patientList1.add(listData1(text_fname, text_lname, text_initial_fname, text_initial_lname, text_gender, text_blood_type, text_doctor_name));  // add elements to the list
                              }); 
                              */                             
                            } 
                          },
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [                   
                                Text(
                                  'Go Back',
                                  textAlign: TextAlign.center,
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
                        SizedBox(width: 40),
                        /* Add Button */
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF373C88),
                            foregroundColor: Colors.white, 
                          ),
                          onPressed: () async {
                            if (formKey1.currentState!.validate()){
                              newPatient(); 
                              Navigator.of(context).pop();  
                              /*                            
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ), // go to patient home pages
                              );
                              */
                              setState(() {
                                patientList1.add(listData1(text_fname, text_lname, text_initial_fname, text_initial_lname, text_gender, text_blood_type, text_doctor_name));  // add elements to the list
                              });                              
                            } 
                          },
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [                   
                                Text(
                                  'Next',
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
    ),
    );
  }
  */

  
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
