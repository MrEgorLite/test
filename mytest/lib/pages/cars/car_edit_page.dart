import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mytest/modules/http.dart';
import 'car_list_page.dart';

class PostEditPage extends StatefulWidget {
  final int carId;
  PostEditPage(this.carId);


  @override
  _PostEditPageState createState() => _PostEditPageState(carId);
}

class _PostEditPageState extends StateMVC {
  final int carId;
  _PostEditPageState(this.carId);
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController licencePlateController = TextEditingController();
  String response = "";
  EditCar() async {
    var result = await http_post("Edit-car", {
      "id": carId,
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
    makeController.text=cars[carId].make;
    modelController.text=cars[carId].model;
    licencePlateController.text=cars[carId].licencePlate;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Edit"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
                EditCar();
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