import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_loop/BottomNavigator.dart';
import 'package:learn_loop/services/FetchUserData.dart';
import 'package:learn_loop/services/UpdateUserData.dart';
import 'package:learn_loop/services/Upload_Profile_Picture.dart';
import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:learn_loop/services/Name_Provider.dart';
import 'package:provider/provider.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:learn_loop/services/getUserID.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final Bio = TextEditingController();

  void initState() {
    super.initState();
    Future.microtask(() {
      FetchUserData.fetchBio(context);
    });
    Future.microtask(() {
      FetchUserData.fetchfirstName(context);
    });
    Future.microtask(() {
      FetchUserData.fetchlastName(context);
    });
    Future.microtask(() {
      FetchUserData.fetchInitial(context);
    });
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      final newUrl = await UploadProfilePicture.Upload(_image!, context);
      final userID = await Securestorage.getUserID();
      if (newUrl != null) {
        context.read<UpdateAvatar>().updateAvatar(
          photo: newUrl,
          userID: userID,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Profile picture updated!')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to upload picture')));
      }
    }
  }

  Widget buildtextfields({
    required TextEditingController controller,
    required String label,
  }) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              label,
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 17)),
            ),
          ),
          SizedBox(height: 10),
          if (label == 'Bio')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 98,
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFFFB74D), width: 1.5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsetsGeometry.symmetric(
                      horizontal: 10,
                    ),
                  ),
                  controller: controller,
                ),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                width: 370,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFFFB74D), width: 1.5),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsetsGeometry.symmetric(
                      horizontal: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  controller: controller,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Bio.text = context.watch<NameProvider>().bio.toString();
    firstname.text = context.watch<NameProvider>().firstName.toString();
    lastname.text = context.watch<NameProvider>().lastName.toString();
    final userID = context.watch<UserID>().userID;
    final imageUrl = context.watch<UpdateAvatar>().getPhotoUrl(
      userID.toString(),
    );
    final screenWidth = MediaQuery.of(context).size.width;
    final Initial = context.watch<UpdateAvatar>().getInitial(userID.toString());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 230,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFB74D), // Warm orange
                        Color(0xFFFFCCBC),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigator(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Text(
                            'Edit profile',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share_outlined, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  left: 132,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage:
                            (imageUrl != null && imageUrl.isNotEmpty)
                            ? NetworkImage(imageUrl)
                            : null,
                        child: (imageUrl == null || imageUrl.isEmpty)
                            ? Text(
                                Initial??"",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -38,
                  right: 145,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 12,
                      child: Icon(Icons.edit, size: 22, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 55, left: 135),
              child: Text(
                'Change profile',
                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 17)),
              ),
            ),
            buildtextfields(controller: firstname, label: 'First Name'),
            buildtextfields(controller: lastname, label: 'Last Name'),
            buildtextfields(controller: Bio, label: 'Bio'),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(250, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  if (firstname.text.isEmpty || lastname.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fillup the required fields'),
                      ),
                    );
                    return;
                  }
                  UpdateUserData.updateData(
                    context: context,
                    firstname: firstname,
                    lastname: lastname,
                    bio: Bio,
                  );
                },
                child: Text(
                  'Update',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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
