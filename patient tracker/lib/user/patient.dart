import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font
import 'package:stroke_text/stroke_text.dart'; // for using outline to text
import 'package:practice/user/patient_list.dart';

class listData {
  String fName;
  String lName;
  int patientID;

  listData (this.fName, this.lName, this.patientID);
}

// patient list
//List<listData> patientList = [];

//List<String> patientList  = ['Kazuya'];

class add_patient extends StatefulWidget {
  add_patient ({Key? key}) : super(key:key);
  //const MyWidget({super.key});
  @override
  State<add_patient> createState() => _add_patient();
}


List<listData> patientList = <listData>[]; 

class _add_patient extends State<add_patient> {

  // create Controller
  final TextEditingController patient_fname = TextEditingController();
  final TextEditingController patient_lname = TextEditingController();
  final TextEditingController patient_ID = TextEditingController();  

  // patient data list
  newPatient(){
    debugPrint(patient_fname.text);
    debugPrint(patient_lname.text);
    debugPrint(patient_ID.text);
    final num = patientList.length;
    debugPrint(num.toString());
    patient_fname.clear();
    patient_lname.clear();
    patient_ID.clear();
  }

  
  createList(){
    if (patientList.length == 0){
      return patient_list();
    }    
    else {
      return Text('Patient List:');
    }    
  }
  
  
  String text_fname = '';
  String text_lname = '';
  int text_patientID = 0;
  

  // create form
  Future<void> InputDialog(BuildContext context) async {
    return showDialog(    
      context: context,
      builder: (context) {
        return AlertDialog(
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
                    Navigator.pop(context);
                    //newPatient(); 
                  },
                ),
              ],
            ),          
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // First Name
                Container(
                  width: 210,
                  height: 56,
                  child: TextField(
                    controller: patient_fname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      hintText: 'Enter here...',
                    ),
                    onChanged: (String value){
                      setState(() {
                        text_fname = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                // Last Name
                Container(
                  width: 210,
                  height: 56,
                  child: TextField(
                    controller: patient_lname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      hintText: 'Enter here...',
                    ),
                    onChanged: (String value){
                      setState(() {
                        text_lname = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                // Patient ID
                Container(
                  width: 210,
                  height: 56,
                  child: TextField(
                    controller: patient_ID,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Patient ID',
                      hintText: 'Enter here...',
                    ),
                    onChanged: (String value){
                      setState(() {
                        text_patientID = int.parse(value);  // convert string to int
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF373C88),
                          foregroundColor: Colors.white, 
                        ),
                        onPressed: () async {
                          //Navigator.of(context).pop(_text);
                          newPatient(); 
                          Navigator.of(context).pop();
                          setState(() {
                            patientList.add(listData(text_fname, text_lname, text_patientID));  // add elements to the list
                          });
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
                                  height: 0.10,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),                    
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),        
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color.(0xffE5E5E5)
      body: Container(   
        width: double.infinity,     
        child: ListView(
          children: [
            Column(  
              crossAxisAlignment: CrossAxisAlignment.center,      
              children: [
                //patient_list(),            
                SizedBox(height: 30), 
                // create a list based on input data            
                createList(),                
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), 
                    itemCount: patientList.length,
                    itemBuilder: (context, index){
                      return Card (    
                        margin: EdgeInsets.all(10),
                        color: const Color(0xFFF4F4F4),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: const Color(0xFF373C88), // border color
                            width: 1, // border thickness                              
                          ),   
                          borderRadius: BorderRadius.circular(10)        
                        ),
                        child: ListTile(      
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: (){

                                }, 
                                icon: Icon(Icons.favorite_outline_outlined)
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                backgroundColor: Color(0xFF373C88),
                                child: Text(
                                  'MK',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3),
                            ],
                          ),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                patientList[index].fName,
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF373C88),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  //height: 0.09,
                                  letterSpacing: 0.15,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                patientList[index].lName,
                                style: GoogleFonts.roboto(
                                  color: Color(0xFF373C88),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  //height: 0.09,
                                  letterSpacing: 0.15,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Dr. Joseph Green',
                            style: GoogleFonts.roboto(
                              color: Color(0xFF373C88),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                              letterSpacing: 0.25,
                            ),
                          ),
                          trailing: IconButton(                          
                            onPressed: (){
                            }, 
                            icon: Icon(Icons.do_not_disturb_on),
                          ),   
                        ),   
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),                          
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF373C88),
                    foregroundColor: Colors.white
                  ),
                  onPressed: () async {                
                    InputDialog(context);                  
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
                          'New Patient',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.10,
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

