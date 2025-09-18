import 'dart:convert';
import 'package:learn_loop/verification_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:learn_loop/services/flutter_secure_storage_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  ForgotPassword_state createState() => ForgotPassword_state();
}

class ForgotPassword_state extends State<ForgotPassword> {
 static final TextEditingController email = TextEditingController();
  Future<void> verifyEmail() async {
    final token = await Securestorage.getToken();
    if (token == null) {
      return;
    }
    if(email.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter the email address')));
      return;
    }

    showDialog(context: context,barrierDismissible: false, builder: (BuildContext context){
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
        child: Padding(padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text('Sending OTP...')
          ],
        ),
        ),
      );
    });



    final url = Uri.parse('http://10.0.2.2:3000/api/auth/verify-email');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'email':email.text.trim()
        })
      );
      if (response.statusCode == 200) {
        final message = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message['message'])));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification_code()));
      }
      if (response.statusCode == 400) {
        final message = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message['message'])));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Internal error occurred')));
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
                      MaterialPageRoute(builder: (context) => Login_page()),
                    );
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black, size: 25),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Please enter your email address',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white, fontSize: 20),
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
                  controller: email,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
                    hintStyle: GoogleFonts.aBeeZee(),
                    prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(left: 4.5, top: 2),
                      child: Icon(Icons.email),
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
                  verifyEmail();
                },
                child: Text('Continue', style: GoogleFonts.aBeeZee()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
