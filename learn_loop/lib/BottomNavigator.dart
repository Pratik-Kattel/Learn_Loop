import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_loop/HomePage.dart';
import 'package:learn_loop/PersonPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:learn_loop/services/notification_provider.dart';
import 'package:learn_loop/services/flutter_secure_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:learn_loop/UserSettings.dart';
import 'package:learn_loop/services/FetchUserData.dart';
import 'package:learn_loop/services/getUserID.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  BottomNavigator_state createState() => BottomNavigator_state();
}

class BottomNavigator_state extends State<BottomNavigator> {
  int selectedItem = 0;

  void initState() {
    super.initState();
    Future.microtask(() async {
      FetchUserData.fetchInitial(context);
      final userID = await Securestorage.getUserID();
      final url = await Securestorage.getImageUrl(userID!);
      if (url != null) {
        context.read<UpdateAvatar>().updateAvatar(photo: url, userID: userID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationCount = context
        .watch<NotificationProvider>()
        .notification;
    final userID=context.watch<UserID>().userID;
    final Avatar = context.watch<UpdateAvatar>();
    final photoUrl = Avatar.getPhotoUrl(userID.toString());
    final initial = Avatar.getInitial(userID.toString());

    final List<Map<String, dynamic>> pages = [
      {
        'page': Homepage(),
        'appbar': AppBar(
          title: Text(
            'Learn Loop',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                letterSpacing: 0.2,
              ),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 100),
              child: IconButton(
                onPressed: () async {
                  context.read<NotificationProvider>().clearNotification();
                  final userID = await Securestorage.getToken();
                  final url = await Securestorage.getImageUrl(userID!);
                  print(url);
                },
                icon: notificationCount == 0
                    ? Icon(Icons.notifications_none)
                    : Icon(Icons.notifications_active_outlined),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: photoUrl != null && photoUrl.isNotEmpty
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
            ),
          ],
        ),
        'backgrounder': Theme.of(context).cardColor,
      },
      {
        'page': PersonPage(),
        'appbar': AppBar(
          title: Text(
            'My Profile',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 1,
              ),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        'backgrounder': Theme.of(context).cardColor,
      },
      {
        'page': UserSettings(),
        'appbar': AppBar(
          title: Text('Settings'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        'backgrounder': Theme.of(context).cardColor,
      },
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedItem,
        onTap: (index) {
          setState(() {
            selectedItem = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      appBar: pages[selectedItem]['appbar'],
      backgroundColor: pages[selectedItem]['backgrounder'],
      body: pages[selectedItem]['page'],
    );
  }
}
