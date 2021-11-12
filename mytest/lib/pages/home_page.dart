import 'package:flutter/material.dart';
import 'cars/car_list_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Json Placeholder App',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarListPage(),
    );

  }
}
