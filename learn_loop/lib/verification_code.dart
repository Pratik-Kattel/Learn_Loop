import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_loop/ChangePassword.dart';
import 'ForgotPassword.dart';
class Verification_code extends StatefulWidget {
  const Verification_code({super.key});

  @override
  Verification_code_state createState() => Verification_code_state();
}

class Verification_code_state extends State<Verification_code> {
  final TextEditingController otp = TextEditingController();
  
  Future<void> otpverify() async{
    final url=Uri.parse('http://10.0.2.2:3000/api/auth/verification-otp');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': ForgotPassword_state.email.text.trim(),
            'otp': otp.text.trim()
          })
      );
      if(response.statusCode==200){
        final message=jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message['message'])));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
      }
      if(response.statusCode==400){
        final message=jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message['message'])));
      }
      if(response.statusCode==500){
        final message=jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message['message'])));
      }

    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Internal error occurred')));
    }

  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFB74D), // Warm orange
              Color(0xFFFFCCBC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black, size: 25),
                ),
              ),
              SizedBox(height: 20),
              Padding(padding: EdgeInsetsGeometry.only(left: 10),child:
              Text(
                'Please the six digit verification code sent to your gmail.',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ),
              SizedBox(height: 35),
              Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: otp,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter six digit code',
                    hintStyle: GoogleFonts.aBeeZee(),
                    prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(left: 4.5, top: 2),
                      child: Icon(Icons.pin),
                    ),
                    contentPadding: EdgeInsetsGeometry.only(left: 30, top: 13),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.59),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4E342E),
                  foregroundColor: Colors.white,
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                ),
                onPressed: () {
                 otpverify();
                },
                child: Text('Verify', style: GoogleFonts.aBeeZee()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
