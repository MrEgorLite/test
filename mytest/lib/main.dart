import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Json Placeholder App',
      debugShowCheckedModeBanner: false, //Убирает банер
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: HomePage(),
    );
  }
}