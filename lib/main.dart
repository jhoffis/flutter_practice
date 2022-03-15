import 'dart:math';

import 'package:flutter/material.dart';
import 'other_page.dart';

const app = MyApp();

void main() {
  runApp(const MaterialApp(home: app));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteWidgetState();
}

bool _pressedSuicide = false;

class _FavoriteWidgetState extends State<MyApp> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  Text jackText = const Text("This is Jack. He's mad.");

  @override
  Widget build(BuildContext context) {
    if (!_pressedSuicide) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Imaggeee"),
        ),
        body: Wrap(children: <Widget>[
          Image.asset(
              'assets/images/movie-300-helmet-shield-wallpaper-thumb.jpg'),
          jackText,
          SizedBox(
            width: 200,
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.blue, backgroundColor: Colors.amberAccent),
              onPressed: () {
                setState(() {
                  _pressedSuicide = !_pressedSuicide;
                });
              },
              child: const Text('Fight him.'),
            ),
          ),
          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {
              Navigator.push(context, _createRoute(() {
                setState(() {});
              }));
            },
            child: const Text('Go around him because you\'re weak'),
          )
        ]),
        bottomNavigationBar: (!_pressedSuicide
            ? const BottomAppBar(
                child: Text(
                    "Cam on ingerland! Score some faking goals!! ENG 7-1 BRA"))
            : const Text("asd")),
      );
    } else {
      return DiedPage();
    }
  }
}

Route _createRoute(Function() updateFunc) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        MapScene(updateFunc: updateFunc),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class MapScene extends StatelessWidget {
  final Function() updateFunc;

  const MapScene({Key? key, required this.updateFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Route'),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/1a4314_47bd8f4a28014766a9a4a9c2ec051eac~mv2.jpg'),
                  fit: BoxFit.cover)),
          child: ListView(children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Face Jack again!'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _pressedSuicide = true;
                updateFunc();
              },
              child: const Text('Drink from that weird brown bottle'),
            ),
            ElevatedButton(
              onPressed: () {
                var ran = Random();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PracticePage(
                            success: ran.nextBool(),
                            context: context,
                          )),
                );
              },
              child: const Text('Practice your skills brah'),
            ),
          ]),
          constraints: const BoxConstraints.expand(),
          // width: double.infinity,
          // height: 500,
        ));
  }
}
