import 'package:appqr/src/pages/mapa_page.dart';
import 'package:flutter/material.dart';

import 'package:appqr/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mapa': (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 128, 128, 1.0),
      ),
    );
  }
}
