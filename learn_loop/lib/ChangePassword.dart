import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_loop/ForgotPassword.dart';

class ChangePassword extends StatefulWidget{
  const ChangePassword({super.key});

  @override
  ChangePassword_state createState()=>ChangePassword_state();
}

 class ChangePassword_state extends State<ChangePassword>{
  bool obsecureText=true;
  final TextEditingController password=TextEditingController();
  final TextEditingController newPassword=TextEditingController();

  Future<void> passwordChange() async{
    if(password.text.isEmpty||newPassword.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fillup the required fields')));
      return;
    }
    if(password.text!=newPassword.text){
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
        );
      });
       return;
    }
    
    final url=Uri.parse('http://10.0.2.2:3000/api/auth/change-password');
    try{
      final response=await http.post(
        url,
        headers: {
          'Content-Type':'application/json',
        },
        body:jsonEncode(
         {
           'email':ForgotPassword_state.email.text,
           'password':newPassword.text.trim()
         }
      )
      );
      if(response.statusCode==200){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_page()));
        final message=jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message['message'])));
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
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Internal error occurred')));

    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFFFB74D), // Warm orange
            Color(0xFFFFCCBC),
          ],
          begin: Alignment.topLeft,
            end: Alignment.bottomCenter
          )
        ),
        child: SafeArea(child:
        Column(
          children: [
            SizedBox(height: 75),
            Text(
              'Enter your new password here',
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
                controller: password,
                obscureText: obsecureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter the password',
                  hintStyle: GoogleFonts.aBeeZee(),
                  prefixIcon: Padding(
                    padding: EdgeInsetsGeometry.only(left: 4.5, top: 2),
                    child: IconButton(onPressed: (){
                      setState(() {
                        obsecureText=!obsecureText;
                      });
                    }, icon: Icon(obsecureText?Icons.visibility_off:Icons.visibility))
                  ),
                  contentPadding: EdgeInsetsGeometry.only(left: 30, top: 13),
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 35),
            Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: newPassword,
                obscureText: obsecureText,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Re-enter the password',
                  hintStyle: GoogleFonts.aBeeZee(),
                  prefixIcon: Padding(
                      padding: EdgeInsetsGeometry.only(left: 4.5, top: 2),
                      child: IconButton(onPressed: (){
                        setState(() {
                          obsecureText=!obsecureText;
                        });
                      }, icon: Icon(obsecureText?Icons.visibility_off:Icons.visibility))
                  ),
                  contentPadding: EdgeInsetsGeometry.only(left: 30, top: 13),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4E342E),
                  foregroundColor: Colors.white,
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                ),
                onPressed: (){
                  passwordChange();
                }, child: Text('Confirm'))
          ],
        )
        ),
      ),
    );
  }
 }
