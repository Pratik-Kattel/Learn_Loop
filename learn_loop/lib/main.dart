import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_loop/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:learn_loop/services/notification_provider.dart';
import 'package:learn_loop/services/Initial_Provider.dart';
import 'package:learn_loop/PersonPage.dart';
import 'package:learn_loop/services/Name_Provider.dart';
import 'package:learn_loop/services/ThemeProvider.dart';
import 'package:learn_loop/services/getUserID.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ChangeNotifierProvider(create: (context) => UpdateAvatar()),
      ChangeNotifierProvider(create: (context) => NameProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context)=>UserID()),
    ],
    child: const myapp(),
  ),
);

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final userID=context.read<UserID>().userID;
    final theme=themeProvider.getIsDark(userID??'') ?? false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: theme? ThemeMode.dark : ThemeMode.light,
      home: splash_screen(),
    );
  }
}
