import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class getStarted extends StatefulWidget{
  const getStarted({super.key});

  @override
  getStarted_state createState()=>getStarted_state();
}

class getStarted_state extends State<getStarted>{
  final List<String> imageList = [
    'assets/images/slider_image_1.jpeg',
    'assets/images/slider_image_2.jpeg',
    'assets/images/slider_image_3.jpeg',
    'assets/images/slider_image_4.jpeg'
  ];
  int current_index=0;
  @override
  Widget build(BuildContext context){
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor:Color(0xFFFFCCBC),
        body: SafeArea(
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight*0.05,
                      ),
                      Text('Learn Loop',
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                              fontSize: 40,
                              color: Color(0xFF4E342E) ,
                              letterSpacing: 5
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight*0.07,
                      ),
                      SizedBox(
                        height: 300,
                        width: 350,
                        child: CarouselSlider(items:
                        imageList.map((imgpath){
                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 4)
                                    )
                                  ]
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child:
                                  Image.asset(
                                    imgpath,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  )
                              )
                          );
                        }).toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(milliseconds: 1500),
                              enlargeCenterPage: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index,reason){
                                setState(() {
                                  current_index=index;
                                });
                              }
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight*0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry){
                          return AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current_index==entry.key?Colors.indigoAccent:Colors.white,
                            ),
                          );
                        }).toList()
                      ),
                      SizedBox(
                        height: screenHeight*0.2,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E342E),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_page()));
                          }, child: Text('Get Started',style: GoogleFonts.aBeeZee(
                      ),)
                      )
                    ]
                )
            )
        )
    );
  }
}