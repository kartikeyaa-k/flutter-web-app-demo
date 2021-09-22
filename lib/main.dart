import 'package:flutter/material.dart';
import 'package:nuchange_web_app/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(97, 65, 107, .1),
      100: Color.fromRGBO(97, 65, 107, .2),
      200: Color.fromRGBO(97, 65, 107, .3),
      300: Color.fromRGBO(97, 65, 107, .4),
      400: Color.fromRGBO(97, 65, 107, .5),
      500: Color.fromRGBO(97, 65, 107, .6),
      600: Color.fromRGBO(97, 65, 107, .7),
      700: Color.fromRGBO(97, 65, 107, .8),
      800: Color.fromRGBO(97, 65, 107, .9),
      900: Color.fromRGBO(97, 65, 107, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFFC3B1E1, color);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Nuchange Web App',
        theme: ThemeData(
          primarySwatch: colorCustom,
        ),
        home: HomeView());
  }
}
