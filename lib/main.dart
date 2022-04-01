import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:untitled3/creature.dart';

import 'battle.dart';

void main() {
  initCreatures();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Jack Hastougo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var audioPlayer_music = AudioPlayer();
final player_music = AudioCache(fixedPlayer: audioPlayer_music);
var audioPlayer_lightning = AudioPlayer();
final player_lightning = AudioCache(fixedPlayer: audioPlayer_lightning);
var audioPlayer_rain = AudioPlayer();
final player_rain = AudioCache(fixedPlayer: audioPlayer_rain);


class _MyHomePageState extends State<MyHomePage> {
  bool lightning = false;
  bool inited = false; // TODO find a way to run this once at initialization without checking every build
  bool end = false;
  void strikeLighting() {
    if (end) {
      return;
    }

    setState(() {
      lightning = !lightning;
      int time = 1000;
      if (!lightning) {
        var ran = Random();
        time += ran.nextInt(7000);
      } else {
        audioPlayer_lightning.stop();
        player_lightning.play("sounds/lightning.wav");
        time = (time.toDouble() * .5).round();
      }
      Timer(Duration(milliseconds: time), strikeLighting);
    });
  }

  @override
  Widget build(BuildContext context) {
    audioPlayer_rain.setVolume(0.3);

    if (!inited) {
      inited = true;
      end = false;
      
      // playLocal() async {
      //   int result = await audioPlayer.play("main.mp3", isLocal: true);
      // }
      // playLocal();

      // call this method when desired
      player_music.play('sounds/main.mp3');
      player_rain.loop('sounds/rain.wav');
      strikeLighting();
    }


    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      decoration: !lightning
          ? const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/main_page.jpg'),
                  fit: BoxFit.cover))
          : const BoxDecoration(color: Color(0xFFDDDDFF)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(
              flex: 8,
            ),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                color: Colors.black54,
                child: Text(
                  super.widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFDDC9B4),
                    fontSize: 42,
                    decoration: TextDecoration.none,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(5, 5))
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Battle(),
                    ));
                audioPlayer_music.stop();
                audioPlayer_rain.stop();
                end = true;
              },
              child: const Text('Start a new game',
                  style: TextStyle(color: Color(0xFFDDC9B4), fontSize: 24)),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF0B3954),
                  minimumSize: const Size(300, 100),
                  side: const BorderSide(
                    width: 5.0,
                    color: Color(0xFF7A6C5D),
                  )),
            ),
            const Spacer(
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
