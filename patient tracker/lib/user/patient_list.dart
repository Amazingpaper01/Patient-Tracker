import 'package:flutter/material.dart';

// create the list for patient data
class PatientData {
  String lastName;
  String firstName;
  PatientData(this.lastName, this.firstName);
}

/*
// list
List<PatientData> dataList = <PatientData>[
  PatientData('Kazuya', 'Mishima'),
];
*/
/*
class MyPatientList extends StatefulWidget {
  //MyPatientList({Key key}) : super(key: key);

  @override
  State<MyPatientList> createState() => _MyPatientList();
}

class _MyPatientList extends State<MyPatientList> {
  // list with data
  List<String> dataList = [];

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
*/

class patient_list extends StatelessWidget {
  //const patient_list({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            children: [
              SizedBox(height: 70),
                Text(
                  'Currently No Patients',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 0.07,
                    letterSpacing: 0.10,
                  ),
                ),            
                SizedBox(height: 30),
                Container(
                  width: 320,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFCAC4D0),
                      ),
                    )
                  ),
                ),
            ],
          ),
        );
    
  }
}