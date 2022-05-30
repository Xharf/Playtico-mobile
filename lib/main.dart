import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playticoapp/screens/homepage.dart';
import 'package:playticoapp/screens/profilepage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:playticoapp/routing.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/screens/registerpage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:playticoapp/models/playlists_hive_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(PlaylistHiveAdapter());
  await Hive.openBox<PlaylistHive>("playlists_hive_model");

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
      home: LoginPage(),
    );
  }
}
