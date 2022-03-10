import 'package:flutter/material.dart';
import 'other_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<MyApp> {

  bool presss = false;

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  Text jackText = Text("This is Jack. He's mad.");

  @override
  Widget build(BuildContext context) {
    if (!presss)
      return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text("Imaggeee"),
            ),
            body: Wrap(children: <Widget>[
              Image.asset('assets/images/movie-300-helmet-shield-wallpaper-thumb.jpg'),
              jackText,
              Container(
                width: 200,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.blue,
                      backgroundColor: Colors.amberAccent
                  ),
                  onPressed: () {
                    setState(() {
                      presss = !presss;
                    });
                  },
                  child: Text('Fight him.'),
                ),
              ),
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  if (presss) {
                    jackText = Text(super.toString());
                  } else {
                    jackText = const Text("eyoooo");
                  }
                },
                child: Text('Looks like I have to go.'),
              )

            ]),
            bottomNavigationBar: (presss ? const BottomAppBar(
                child: Text("Cam on ingerland! Score some faking goals!! ENG 7-1 BRA")
            ) : Text("asd")),
          )
      );
    else
      return new OtherPage();
  }
}