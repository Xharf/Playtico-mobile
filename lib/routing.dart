import 'package:flutter/material.dart';
import 'package:playticoapp/screens/loginpage.dart';
import 'package:playticoapp/screens/playingnowpage.dart';
import 'package:playticoapp/screens/registerpage.dart';
import 'package:playticoapp/screens/homepage.dart';

class Routing extends StatelessWidget {
  const Routing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: Text("Register"),
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(builder: (context) => RegisterPage())
                  );
                },
              ),
            ),
            SizedBox(
                height: 20
            ),
            Center(
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(builder: (context) => LoginPage())
                  );
                },
              ),
            ),
            SizedBox(
                height: 20
            ),
            Center(
              child: ElevatedButton(
                child: Text("homepage"),
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(builder: (context) => HomePage())
                  );
                },
              ),
            ),
            SizedBox(
                height: 20
            ),
            Center(
              child: ElevatedButton(
                child: Text("homepage"),
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(builder: (context) => PlayingNow(songId: 'song-fjWd6hCuDnvhJMeR',songUrl: 'https://storage.googleapis.com/playtico-0123.appspot.com/TULUS - Cahaya.mp3',))
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
