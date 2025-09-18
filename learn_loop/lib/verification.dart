import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/login_page.dart';
import 'package:learn_loop/signup.dart';
import 'package:http/http.dart' as http;

class Verification extends StatefulWidget{
  final String email;
   const Verification({super.key ,required this.email});
  Verification_state createState()=> Verification_state();
}


class Verification_state extends State<Verification>{
  final verification_code=TextEditingController();
  @override
  Widget build(BuildContext context){
    Future<void> verifyOTP() async{
      final code=verification_code.text.trim();
      if(code.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fillup the verification code')));
        return;
      }
      final url = Uri.parse('http://10.0.2.2:3000/api/auth/verifyOTP');
      final response=await http.post(
        url,
        headers: {'Content-Type':'application/json'},
        body: jsonEncode({
          'email':widget.email,
          'otp':code
        })
      );
      final body=jsonDecode(response.body);
      if(response.statusCode==200){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful')));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_page()));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:Text('Invalid code')));
      }
    }


    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFB74D), // Warm orange
              Color(0xFFFFCCBC), // Light peach
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight*0.05,
            ),
           Align(
             alignment: Alignment.centerLeft,
             child: IconButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
             }, icon: Icon(Icons.arrow_back))
           ),
            SizedBox(
              height: screenHeight*0.015,
            ),
            Padding(padding: EdgeInsets.all(15),child:
            Text('Enter the 6 digit verification code that has been sent to your google account',style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xFF4E342E)
              )
            ),
            )
            ),
            SizedBox(
              height: screenHeight*0.1,
            ),
            Container(
              height: 55,
              width: 370,
              decoration:   BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4)
                    )
                  ],
                  border: Border.all(
                      color: Color(0xFFFFB74D),
                      width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              child:
              TextField(
                controller: verification_code,
                decoration: InputDecoration(
                    contentPadding: EdgeInsetsGeometry.only(left: 25,top: 15),
                    prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),child:  Icon(Icons.email,size: 24,),),
                    border: InputBorder.none,
                    hintText: 'Enter code here',
                    hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.2,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4E342E),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: verifyOTP
                , child: Text('Confirm',style: GoogleFonts.poppins(
            ),))
          ],
        ),
      ),
    );
  }

}