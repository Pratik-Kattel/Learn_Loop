import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/get_started.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  splash_screen_state createState() => splash_screen_state();
}

class splash_screen_state extends State<splash_screen> {
  bool _showlogo=false;
  bool _showslogan=false;
  bool _showfooter=false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 600),(){
      setState(() {
        _showlogo=true;
      });
    });
    Future.delayed(Duration(milliseconds: 1500),(){
      setState(() {
        _showslogan=true;
      });
    });
    Future.delayed(Duration(milliseconds: 2500),(){
      setState(() {
        _showfooter=true;
      });
    });
    Future.delayed(Duration(seconds: 4),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>getStarted()));
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB74D), Color(0xFFFFCCBC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.31),
            AnimatedOpacity(
              duration: Duration(milliseconds: 600),
              opacity: _showlogo?1.0:0.0,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/App_Logo.png'),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            AnimatedOpacity(
              duration: Duration(milliseconds: 1500),
              opacity: _showslogan?1.0:0.0,
              child: Text(
                  "Learn Loop — Where Learning Never Ends.",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4E342E),
                    ),
                  ),
                ),
            ),
            SizedBox(height: screenHeight * 0.45),
          AnimatedOpacity(
            duration: Duration(milliseconds: 2500),
            opacity: _showfooter?1.0:0.0,
            child:   Text(
              '© 2025 Pratik Kattel',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4E342E),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
