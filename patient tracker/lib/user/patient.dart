import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/main.dart';  
import 'package:practice/user/patientInfo.dart'; // for patient Home 
import 'package:practice/user/patient_list.dart'; // for initial message to the list
import 'package:google_fonts/google_fonts.dart'; // for using Google Font


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

  listData (this.fName, this.lName, this.patientID, this.initial_fName, this.initial_lName, this.isFavorite, this.fav, this.numIndex, this.favIndex);
}


class add_patient extends StatefulWidget {
  add_patient ({Key? key}) : super(key:key);
  //const MyWidget({super.key});
  @override
  State<add_patient> createState() => _add_patient();
}


/* List for Patient Data */
List<listData> patientList = <listData>[];  


class _add_patient extends State<add_patient> {
  /* create Controller */
  final TextEditingController patient_fname = TextEditingController();
  final TextEditingController patient_lname = TextEditingController();
  final TextEditingController patient_ID = TextEditingController();  

  /* patient data list */
  newPatient(){
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
  String text_initial_fname = '';  // initial first name
  String text_initial_lname = '';  // initial last name

  /* Favorite Button */
  bool _isFavorite = true;  // for favorite button codition (true or false)
  int _fav = 0;  // for favorite button condition (0 or 1)
  int _numIndex = 0; // index number
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
                          text_fname = value;
                          text_initial_fname = text_fname[0];
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
                              newPatient(); 
                              Navigator.of(context).pop();
                              setState(() {
                                patientList.add(listData(text_fname, text_lname, text_patientID, text_initial_fname, text_initial_lname, _isFavorite, _fav, _numIndex, _favIndex));  // add elements to the list
                                _numIndex++;
                                debugPrint(_numIndex.toString());
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
                              'Dr. Joseph Green',
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
                          'New Patient',
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

