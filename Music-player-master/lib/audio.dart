//import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/web/audioplayers_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  int height = 100;
  AudioPlayer audioPlayer =  AudioPlayer();
 // late AudioCache audioCache;
  Duration duration =  Duration();
  Duration position =  Duration();
  bool playing = false;

  //
  // @override
  //  void initState(){
  //   super.initState();
  //
  //   audioCache = AudioCache(fixedPlayer: audioPlayer);
  //   audioPlayer.onPlayerStateChanged.listen((AudioPlayer) {
  //     setState(() {
  //       AudioPlayer = audioPlayer as PlayerState;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose(){
  //   super.dispose();
  //   audioPlayer.release();
  //   audioPlayer.dispose();
  // }
  //
  // playMusic() async{
  //   await audioPlayer.play;
  // }
  //
  // pauseMusic() async{
  //   await audioPlayer.pause;
  // }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage('images/5.jpeg',),),

                slider(

                ),

                InkWell(
                  onTap: (){
                    getAudio();
                  },
                  child: Icon(
                    playing == false
                        ? Icons.play_circle_outline
                        : Icons.pause_circle_outline,
                    size: 100,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget slider(){
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbColor: Color(0xFFEB1555),
        activeTrackColor: Colors.white,
        overlayColor: Color(0x29EB1555),
        inactiveTrackColor: Colors.grey,
        thumbShape:
        RoundSliderThumbShape(enabledThumbRadius: 15.0),
        overlayShape:
        RoundSliderOverlayShape(overlayRadius: 30.0),
      ),
      child: Slider(
        value: height.toDouble(),
        min: 0.0,
        max: 250.0,
        onChanged: (double newValue) {
          setState(() {
            height = newValue.round();
          });
        },
      ),
    );

    // return Slider.adaptive(
    //     min: 0.0,
    //     max: duration.inSeconds.toDouble(),
    //     value: duration.inSeconds.toDouble(),
    //     activeColor: Colors.green,
    //     onChanged: (double value){
    //     setState(() {
    //       audioPlayer.seek(Duration(seconds: value.toInt()));
    //     });
    //     },
    // );
  }
  Future<void> getAudio() async {
    var url = 'https://assets.mixkit.co/music/preview/mixkit-tech-house-vibes-130.mp3';
        if(playing) {
          print(playing.toString()+ ">>>>>>>>>>>>>>>>>>");
          var res = await audioPlayer.pause();
          if(res == 1){
            setState(() {
              playing = false;
              //print(playing.toString()+ ">>>>>>>>>>>>>>>>>>");
            });
          }
        }else{
          print(playing.toString()+ "<<<<<<<<<<<<<<<<<<<");
          var res =  await audioPlayer.play(url, isLocal: true);
          if(res == 1){
            setState(() {
              playing = true;
              //print(playing.toString()+ ">>>>>>>>>>>>>>>>>>");
            });
          }
        }

        audioPlayer.onDurationChanged.listen((Duration dd) {
          setState(() {
            duration = dd;
          });
        });
        audioPlayer.onAudioPositionChanged.listen((Duration dd) {
          setState(() {
            position = dd;
          });
        });
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<AudioCache>('audioCache', audioCache));
  // }
}
