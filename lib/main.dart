import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:playticoapp/routing.dart';
//import 'package:playticoapp/screens/displaysongspage.dart';
//import 'package:playticoapp/screens/displaysongspage2.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/screens/registerpage.dart';
import 'package:playticoapp/screens/rand2.dart';
import 'package:playticoapp/screens/homepage.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: DisplaySongs(),
      home: Routing(),
    );
  }
}
