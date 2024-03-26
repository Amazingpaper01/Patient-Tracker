import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // for using Google Font


class patient_list extends StatelessWidget {
  //const patient_list({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Currently No Patients',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Color(0xFF373C88),
              fontSize: 24,
              fontWeight: FontWeight.w500,
              height: 0.10,
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

class not_EmptyList extends StatelessWidget {
  //const not_EmptyList({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 0);
  }
}