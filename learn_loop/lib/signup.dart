import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/login_page.dart';
import 'package:learn_loop/verification.dart';
import 'package:learn_loop/services/auth_services.dart';

class Signup extends StatefulWidget{
  const Signup({super.key});

  Signup_state createState()=> Signup_state();
}
class Signup_state extends State<Signup>{
  final email= TextEditingController();
  final password= TextEditingController();
  final first_name=TextEditingController();
  final last_name=TextEditingController();
  bool obscureText=true;
  @override
  Widget build(BuildContext context){
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
              height: screenHeight*0.055,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_page()));
              }, icon: Icon(Icons.arrow_back)),
            ),
            SizedBox(
              height: screenHeight*0.005,
            ),
            Text('Be a part of our family',style:GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Color(0xFF4E342E) ,
                    fontSize: 25,
                    fontWeight: FontWeight.w800
                ),
            )
            ),
            SizedBox(
              height: screenHeight*0.001,
            ),
            Text('Register Now !!',style:GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Color(0xFF4E342E) ,
                  fontSize: 25,
                  fontWeight: FontWeight.w800
              ),
            )
            ),
            SizedBox(
              height: screenHeight*0.02,
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
                  child:  Image.asset('assets/images/register.png',fit: BoxFit.cover,),
                )
            ),
            SizedBox(
              height: screenHeight*0.06,
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
                controller: first_name,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25,top: 15),
                    prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),child:  Icon(Icons.person,size: 24,),),
                    border: InputBorder.none,
                    hintText: 'Enter first name',
                    hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.03,
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
                controller: last_name,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25,top: 15),
                    prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),child:  Icon(Icons.person_2,size: 24,),),
                    border: InputBorder.none,
                    hintText: 'Enter last name',
                    hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.03,
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
                    contentPadding: EdgeInsets.only(left: 25,top: 15),
                    prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),child:  Icon(Icons.email,size: 24,),),
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
                    hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.03,
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
                controller: password,
                obscureText: obscureText,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25,top: 15),
                    prefixIcon:Padding(padding: EdgeInsets.only(top: 5,left: 2),
                      child:IconButton(onPressed: (){
                        setState(() {
                          obscureText=!obscureText;
                        });
                      }, icon:
                      Icon(obscureText?Icons.visibility_off:Icons.visibility)
                      )
                      ,),
                    border: InputBorder.none,
                    hintText: 'Enter new password',
                    hintStyle: GoogleFonts.aBeeZee()
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.05,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4E342E),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () async{

                 final user_first_name=first_name.text.trim();
                 final user_last_name=last_name.text.trim();
                  final useremail=email.text.trim();
                  final userpassword=password.text.trim();


                  if(user_first_name.isEmpty ||user_last_name.isEmpty|| useremail.isEmpty || userpassword.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill up all the required fields')));
                    return;
                  }
                  try{
                   final response= await AuthServices.sendOTP(first_name: user_first_name,last_name: user_last_name, email: useremail, password: userpassword, context: context);
                   if(response.statusCode==400){
                     final message = jsonDecode(response.body);
                     showDialog(context: context, builder:(BuildContext context){
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
                   if(response.statusCode==200){
                     final message = jsonDecode(response.body);
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message['message'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  )
                              ),
                            )
                            )
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification(email: email.text.trim(),)));
                          }
                   }
                  catch(e){
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error: $e')));
                  }
                  },
                 child: Text('Verify',style: GoogleFonts.aBeeZee(
            ),)
            ),
          ],
        ),
        ),
    );
  }
}