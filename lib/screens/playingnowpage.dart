import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:playticoapp/models/song_get_spesific_model.dart';
import 'package:playticoapp/services/songs_data_store.dart';

enum AudioPlayerState { STOPPED, PLAYING, PAUSED, COMPLETED }

class PlayingNow extends StatefulWidget {
  final songId;
  final songUrl;

  const PlayingNow({Key? key, required this.songId, required this.songUrl})
      : super(key: key);

  @override
  State<PlayingNow> createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> {
  int valueHolder = 20;
  int maxduration = 100;
  String maxdurationlabel = "00:00";
  int currentpos = 0;
  String currentpostlabel = "00:00";
  bool isplaying = false;
  bool audioplayed = false;
  Uint8List? audiobytes;
  AudioPlayer player = AudioPlayer();
  String audioasset = "assets/audio/";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ByteData bytes = await rootBundle.load((audioasset +
          (widget.songUrl.split('/').last))); //load audio from assets
      audiobytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        int shours = Duration(milliseconds: maxduration).inHours;
        int sminutes = Duration(milliseconds: maxduration).inMinutes;
        int sseconds = Duration(milliseconds: maxduration).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
        maxdurationlabel = (rhours == 0)
            ? "$rminutes:$rseconds"
            : "$rhours:$rminutes:$rseconds";
        setState(() {});
      });
      player.onAudioPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio
        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = (rhours == 0)
            ? "$rminutes:$rseconds"
            : "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

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
          child: FutureBuilder(
        future: SongDataSource.instance.getSongsById(widget.songId),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text("Some error Appeared");
          }
          if (snapshot.hasData) {
            SongGetSpecificModel songsModel = SongGetSpecificModel.fromJson(snapshot.data);
            return _buildSuccessSection(songsModel.data);
          }
          return _buildLoadingSection();
        },
      )
          //
          ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(data) {
    return Column(
          children: [
            Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(data.song?.cover)
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
                  Text(data.song?.title,
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
              data.song?.performer,
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
                    value: double.parse(currentpos.toString()),
                    min: 0,
                    max: double.parse(maxduration.toString()),
                    divisions: maxduration,
                    activeColor: const Color(0xFF960E96),
                    inactiveColor: const Color(0xFFFF00FF),
                    label: currentpostlabel,
                    onChanged: (double value) async {
                        int seekval = value.round();
                        int result = await player.seek(Duration(milliseconds: seekval));
                        if(result == 1){ //seek successful
                          currentpos = seekval;
                        }else{
                          print("Seek unsuccessful.");
                        }
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
                  Text(currentpostlabel,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color(0xFF960E96),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    maxdurationlabel,
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
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.skip_previous_rounded,
                    ),
                    onPressed: () async{
                      int seekval = currentpos - 10000;
                      int result = await player.seek(Duration(milliseconds: seekval));
                      if(result == 1){ //seek successful
                        currentpos = seekval;
                      }else{
                        print("Seek unsuccessful.");
                      }
                    },
                  ),
                  IconButton(
                    color: Color(0xFF960E96),
                    hoverColor: Color(0x35FF00FF),
                    splashColor: Colors.white,
                    icon: Icon(isplaying?Icons.pause_rounded:Icons.play_arrow_rounded),
                    onPressed: () async {
                      if(!isplaying && !audioplayed){
                        int result = await player.playBytes(audiobytes!);
                        // int result = await player.play(songUrl);
                        if(result == 1){ //play success
                          setState(() {
                            isplaying = true;
                            audioplayed = true;
                          });
                        }else{
                          print("Error while playing audio.");
                        }
                      }else if(audioplayed && !isplaying){
                        int result = await player.resume();
                        if(result == 1){ //resume success
                          setState(() {
                            isplaying = true;
                            audioplayed = true;
                          });
                        }else{
                          print("Error on resume audio.");
                        }
                      }else{
                        int result = await player.pause();
                        if(result == 1){ //pause success
                          setState(() {
                            isplaying = false;
                          });
                        }else{
                          print("Error on pause audio.");
                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.skip_next_rounded),
                    onPressed: () async {
                      int seekval = currentpos + 10000;
                      int result = await player.seek(Duration(milliseconds: seekval));
                      if(result == 1){ //seek successful
                        currentpos = seekval;
                      }else{
                        print("Seek unsuccessful.");
                      }
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
        );
  }
}
