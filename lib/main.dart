import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  bool lightning = false;
  bool inited =
      false; // TODO find a way to run this once at initialization without checking every build

  void strikeLighting() {
    setState(() {
      lightning = !lightning;
      int time = 1000;
      if (!lightning) {
        var ran = Random();
        time += ran.nextInt(7000);
      } else {
        time = (time.toDouble() * .5).round();
      }
      Timer(Duration(milliseconds: time), strikeLighting);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!inited) {
      inited = true;
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
