import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mytest/modules/http.dart';
import 'car_list_page.dart';

class PostDetailPage extends StatefulWidget {

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

// не забываем поменять на StateMVC
class _PostDetailPageState extends StateMVC {

  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController licencePlateController = TextEditingController();
  String response = "";
  addCar() async {
    int x = 0;
    for(int i=0; i < cars.length; i++){
      x = cars[i].id;
    }
    if(cars.length != 0){x=x+1;}
    var result = await http_post("create-car", {
      "id": x,
      "make": makeController.text,
      "model": modelController.text,
      "licencePlate": licencePlateController.text,
    });
    if(result.ok)
    {
      setState(() {
        response = result.data['status'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Add"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
                addCar();
                Navigator.pop(context, );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: _buildContent(),
      ),
    );
  }
  Widget _buildContent() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "make"
            ),
            controller: makeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "пустой";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "model"
            ),
            controller: modelController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "пустой";
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "licencePlate"
            ),
            controller: licencePlateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "пустой";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}