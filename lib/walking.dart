import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'battle.dart';

class Walking extends StatelessWidget {
  const Walking({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var ran = Random();
    Timer(Duration(seconds: ran.nextInt(3) + 1), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(
          builder: (BuildContext context) => Battle(),
        ),
      );
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(children: const [
        Text("Walking..."),
      ]),
    );
  }
}
