import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_loop/login_page.dart';
import 'package:learn_loop/services/ThemeProvider.dart';
import 'package:learn_loop/services/getUserID.dart';
import 'package:provider/provider.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  UserSettings_state createState() => UserSettings_state();
}

class UserSettings_state extends State<UserSettings> {
  Widget settingBuild({
    required String label,
    required Icon prefixIcon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        ListTile(
          leading: prefixIcon,
          title: Text(
            label,
            style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15)),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userID=context.watch<UserID>().userID;
    final theme=context.watch<ThemeProvider>().getIsDark(userID ??'') ?? false;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          settingBuild(
            label: 'Change Password',
            prefixIcon: Icon(Icons.lock_outline, color: Colors.orange),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.indigo),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: theme,
              onChanged: (value) {
                context.read<ThemeProvider>().toggleTheme(value);
              },
            ),
          ),
          settingBuild(
            label: '2F Authentication',
            prefixIcon: Icon(Icons.verified_user, color: Colors.green),
            onTap: () {},
          ),
          settingBuild(
            label: 'Language',
            prefixIcon: Icon(Icons.language, color: Colors.deepPurple),
            onTap: () {},
          ),
          settingBuild(
            label: 'Help and Support',
            prefixIcon: Icon(Icons.help_outline, color: Colors.blueAccent),
            onTap: () {},
          ),
          settingBuild(
            label: 'About',
            prefixIcon: Icon(Icons.info_outline, color: Colors.teal),
            onTap: () {},
          ),
          settingBuild(
            label: 'Log Out',
            prefixIcon: Icon(Icons.logout, color: Colors.red),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout?'),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(color: Colors.red),
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login_page(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'You have been successfully logged out',
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Yes',
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          SizedBox(width: 100),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
