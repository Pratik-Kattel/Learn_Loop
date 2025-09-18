import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/EditProfile.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:learn_loop/services/Name_Provider.dart';
import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:learn_loop/services/FetchUserData.dart';
import 'package:provider/provider.dart';
import 'package:learn_loop/services/getUserID.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  PersonPageState createState() => PersonPageState();
}

class PersonPageState extends State<PersonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      FetchUserData.fetchInitial(context);
      final userID=await Securestorage.getUserID();
      final url = await Securestorage.getImageUrl(userID!);
      if (url != null) {
        context.read<UpdateAvatar>().updateAvatar(photo: url,userID: userID);
      }
    });
    Future.microtask(() {
      FetchUserData.fetchFullName(context);
    });
    Future.microtask(() {
      FetchUserData.fetchBio(context);
    });
    Future.microtask(() {
      FetchUserData.fetchemail(context);
    });
  }

  Widget buildOptions({
    required Icon prefixIcon,
    required String title,
    required VoidCallback onTap,
}
){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: prefixIcon,
            title: Text(title,style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15
              )
            )),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: onTap,
          ),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Avatar = context.watch<UpdateAvatar>();
    final userID=context.watch<UserID>().userID;
    final initial = Avatar.getInitial(userID??'');
    final photoUrl = Avatar.getPhotoUrl(userID??'');
    final fullName = context.watch<NameProvider>().fullName;
    final Bio = context.watch<NameProvider>().bio;
    final email = context.watch<NameProvider>().email;
      return SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            (photoUrl != null && photoUrl.isNotEmpty)
                            ? NetworkImage(photoUrl)
                            : null,
                        child: (photoUrl == null || photoUrl.isEmpty)
                            ? Text(
                                initial ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: -2,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName ?? "Loading...",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          email ?? 'Loading...',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                Bio ?? '',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB74D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(30, 30),
                ),
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text(
                  'Edit profile',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              buildOptions(prefixIcon: Icon(Icons.favorite_border,color: Colors.red,) ,title: 'Liked Notes',onTap: (){}),
              buildOptions(prefixIcon: Icon(Icons.upload_file,color: Colors.blue,), title: 'Uploaded PDFs',onTap: (){}),
              buildOptions(prefixIcon: Icon(Icons.download,color: Colors.green), title: 'Downloaded PDFs',onTap: (){}),
              buildOptions(prefixIcon: Icon(Icons.bookmark,color: Colors.purple,), title: 'BookMarks',onTap: (){}),
              buildOptions(prefixIcon: Icon(Icons.history,color: Colors.orange), title: 'History',onTap: (){}),
              buildOptions(prefixIcon: Icon(Icons.emoji_events,color: Colors.yellow,), title: 'Points',onTap: (){})

              
            ],
          ),
        ),
      ),
    );
  }
}
