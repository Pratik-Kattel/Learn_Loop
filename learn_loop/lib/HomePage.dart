import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/PersonPage.dart';
import 'package:learn_loop/BottomNavigator.dart';
import 'package:learn_loop/services/notification_provider.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget{
  const Homepage({super.key});
  @override
  HomePage_state createState()=>HomePage_state();
}

class HomePage_state extends State<Homepage>{
  final List<Map<String,dynamic>> containers=[
    {
      'icon':Icons.live_tv,
      'color':Colors.blue,
      'content':'Live Classes'
    },
    {
      'icon':Icons.picture_as_pdf,
      'color':Colors.orangeAccent,
      'content':'Download PDF'
    },
    {
      'icon':Icons.upload_file,
      'color':Colors.green,
      'content':'Upload PDFs'
    },
    {
      'icon':Icons.notes,
      'color':Colors.redAccent,
      'content':'Handwritten Notes'
    },

  ];
  @override
  Widget build(BuildContext context){
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
      return Column(
        children: [
                Expanded(child:
                GridView.builder(
                    itemCount: containers.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 20),
                  itemBuilder: (BuildContext context, int index) {
                      final content_data=containers[index];
                      return Padding(padding: EdgeInsets.all(15),child:
                      GestureDetector(
                        onTap: (){
                          print('clicked');
                        },
                    child:
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 4)
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Expanded(child:
                            Center(
                            child:
                               CircleAvatar(
                                radius: 28,
                                backgroundColor: content_data['color'].withOpacity(0.15),
                                child: Icon(content_data['icon'],color: content_data['color'],),
                              ),
                            )
                            ),
                            Padding(padding: EdgeInsetsGeometry.only(bottom: 10),child:
                            Text(content_data['content'],textAlign: TextAlign.center,style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              )
                            ),)
                            )
                          ],
                        )
                    )
                      )
                      );
                  },
                )
                ),
        ],
      );
  }
}

