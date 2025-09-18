import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:learn_loop/signup.dart';
import 'package:learn_loop/services/auth_services.dart';
import 'package:learn_loop/BottomNavigator.dart';
import 'package:learn_loop/ForgotPassword.dart';
import 'package:learn_loop/services/getUserID.dart';
import 'package:provider/provider.dart';

class Login_page extends StatefulWidget{
  const Login_page({super.key});
  @override
  Login_page_state createState()=> Login_page_state();
}

class Login_page_state extends State<Login_page>{
  final email = TextEditingController();
  final password=TextEditingController();
  bool obscureText=true;
  @override
  Widget build(BuildContext context){
    double screenHeight=MediaQuery.of(context).size.height;

    Future<void> login() async{
      if(email.text.isEmpty || password.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fillup the required fields')));
        return;
      }
      final response=await AuthServices.login(email: email.text.trim(), password: password.text.trim());
      final message=jsonDecode(response.body);
      if(response.statusCode==400){
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message['message']),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Ok'))
            ],
          );
        });
      }
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final userID = data['id'];
        final name = data['name'] ?? '';
        final photoUrl = data['photo'] ?? '';

        await Provider.of<UserID>(context, listen: false).getUserID();

        Provider.of<UpdateAvatar>(context, listen: false).updateAvatar(
          userID: userID,
          photo: photoUrl.isNotEmpty ? photoUrl : null,
          initial: name.isNotEmpty ? name[0].toUpperCase() : null,
        );


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigator()),
        );
      }

      if(response.statusCode==500){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('Error'),
            content: Text(message['message']),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Ok'))
            ],
          );
        });
      }

    }

    return Scaffold(
    body:   Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFB74D), // Warm orange
                    Color(0xFFFFCCBC), // Light peach
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
          child: Column(
          children: [
            SizedBox(
              height: screenHeight*0.09,
            ),
            Text('Learn Loop',style:GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 40,
                  color: Color(0xFF4E342E) ,
                fontWeight: FontWeight.w600
              )
            ) ,
            ),
            SizedBox(
              height: screenHeight*0.045,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFFB74D),
                      spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 4)
                  )
                ],
                borderRadius: BorderRadius.circular(20)
              ),
              height: 220,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:  Image.asset('assets/images/login_page.png',fit: BoxFit.cover,),
              )
            ),
            SizedBox(
              height: screenHeight*0.09,
            ),
            Container(
              height: 55,
              width: 350,
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
                controller: email,
                decoration: InputDecoration(
                  contentPadding: EdgeInsetsGeometry.only(left: 25,top: 15),
                  prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),child:  Icon(Icons.email,size: 24,),),
                  border: InputBorder.none,
                  hintText: 'Enter your email address',
                  hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.05,
            ),
            Container(
              height: 55,
              width: 350,
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
                obscureText: obscureText,
                controller: password,
                decoration: InputDecoration(
                    contentPadding: EdgeInsetsGeometry.only(left: 25,top: 15),
                    prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),child:  IconButton(onPressed: (){
                      setState(() {
                        obscureText=!obscureText;
                      });
                    }, icon: Icon(
                     obscureText?Icons.visibility_off:Icons.visibility
                    )
                    )
                    ),
                    border: InputBorder.none,
                    hintText: 'Enter your Password',
                    hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.only(left: 220),child:
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
            }, child: Text('Forgot Password?')),
            ),
            SizedBox(
              height: screenHeight*0.01,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4E342E),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: (){
                  // login();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigator()),
                  );
                }, child: Text('Log in',style: GoogleFonts.aBeeZee(
            ),)
            ),
            SizedBox(
              height: screenHeight*0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Doesn't have an account?",style:GoogleFonts.poppins(
                textStyle: TextStyle(
                color: Color(0xFF4E342E) ,
                fontWeight: FontWeight.w600
            )
    ) ,),
                TextButton(
                    style: TextButton.styleFrom(
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                    }, child: Text('Sign up here',style:GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600
                    )
                ) ,))

              ],
            )
          ],
        ),
      )
    );
  }
}