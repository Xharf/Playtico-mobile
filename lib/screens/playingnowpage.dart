import 'dart:ui';

import 'package:flutter/material.dart';

class PlayingNow extends StatefulWidget {
  const PlayingNow({Key? key}) : super(key: key);

  @override
  State<PlayingNow> createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> {
  int valueHolder = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFFB226B2),
            size: 32,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage("https://storage.googleapis.com/playtico-0123.appspot.com/1652004691582ab67616d0000b2732dedd724077513faa2ff5933.jpg")
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tujuh Belas",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFB226B2),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ))
                ],
              ),
            ),
            Text(
              "Tulus",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFB226B2),
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
              child: SliderTheme(
                data: SliderThemeData(
                  overlayShape: SliderComponentShape.noOverlay
                ),
                child: Slider(
                    value: valueHolder.toDouble(),
                    min: 1,
                    max: 100,
                    divisions: 100,
                    activeColor: const Color(0xFF960E96),
                    inactiveColor: const Color(0xFFFF00FF),
                    label: '${valueHolder.round()}',
                    onChanged: (double newValue) {
                      setState(() {
                        valueHolder = newValue.round();
                      });
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()}';
                    }
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "01:35",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF960E96),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    "03:55",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFFFF00FF),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.shuffle_rounded),
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.skip_previous_rounded,
                    ),
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    color: Color(0xFF960E96),
                    hoverColor: Color(0x35FF00FF),
                    splashColor: Colors.white,
                    icon: Icon(Icons.play_arrow_rounded),
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next_rounded),
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.repeat_rounded),
                    onPressed: (){

                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
