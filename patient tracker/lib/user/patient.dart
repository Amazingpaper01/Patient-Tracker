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
List<listData> patientList = [];

//List<String> patientList  = ['Kazuya'];

class add_patient extends StatefulWidget {
  add_patient ({Key? key}) : super(key:key);
  //const MyWidget({super.key});
  @override
  State<add_patient> createState() => _add_patient();
}

class _add_patient extends State<add_patient> {

  // create Controller
  final TextEditingController patient_fname = TextEditingController();
  final TextEditingController patient_lname = TextEditingController();
  final TextEditingController patient_ID = TextEditingController();  

  // patient data list
  //List<String> patientList  = [];
  List<String> patientList2 = [];

  newPatient(){
    debugPrint(patient_fname.text);
    debugPrint(patient_lname.text);
    debugPrint(patient_ID.text);
    //patientList.add(patient_fname.text);
    final num = patientList.length;
    debugPrint(num.toString());
    patient_fname.clear();
    //debugPrint(patientList[0]);
    //createList();
    //patientList.add(listData('John','Doe',456));
  }

  
  createList(){
    if (patientList2.length == 0){
      return patient_list();
    }
    
    else {
      return Text('Patient List:');
    }
    
  }
  
  
  String _text = '';
  

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
                        _text = value;
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
                          //primary:  // background
                          //onPrimary: // foreground
                          backgroundColor: Color(0xFF373C88),
                          foregroundColor: Colors.white, 
                        ),
                        onPressed: () async {
                          // Add your logic here
                          //Navigator.of(context).pop(_text);
                          newPatient(); 
                          Navigator.of(context).pop();
                          setState(() {
                            patientList2.add(_text);
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
        child: Column(  
            //mainAxisAlignment: MainAxisAlignment.center,
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
                itemCount: patientList2.length,
                itemBuilder: (context, index){
                  return Card(
                    //child: Text(patientList[index].fName),
                    child: ListTile(
                      title: Text(patientList2[index]),
                    ),
                  );
                },
              ),
            ),
            
            /*
            ListView.builder(
              itemCount: patientList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(patientList[index]),
                );
              },
            ),
            */
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
                  //crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [                  
                    Icon(
                        Icons.person_add,
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
      ),
    );
  }
}

