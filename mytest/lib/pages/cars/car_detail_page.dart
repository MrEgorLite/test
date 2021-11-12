import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:mytest/modules/http.dart';
import 'car_edit_page.dart';
import 'car_list_page.dart';
class CarDetailPage extends StatefulWidget {
  final int carId;
  CarDetailPage(this.carId);
  @override
  _CarDetailPage createState() => _CarDetailPage(carId);
}
class _CarDetailPage extends StateMVC {
  final int carId;
  Future<void> refreshCars()async{
    var result = await http_get('testcar');
    if(result.ok)
    {
      setState(() {
        cars.clear();
        var in_cars = result.data as List<dynamic>;
        in_cars.forEach((in_car){
          cars.add(Car(
            in_car['id'],
            in_car['make'],
            in_car['model'],
            in_car['licencePlate'],
          ));
        });
      });
    }
  }
  _CarDetailPage(this.carId);

  @override
  Widget build(BuildContext context) {
    final car = cars[carId];
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FloatingActionButton(
              child: Icon(
                  Icons.delete
              ),
              onPressed: () async {
                String response = "";
                var result = await http_post("Remove-car", {
                  "id": cars[carId].id,
                  "make": cars[carId].make,
                  "model": cars[carId].model,
                  "licencePlate": cars[carId].licencePlate,
                });
                if(result.ok)
                {
                  setState(() {
                    response = result.data['status'];
                  });
                }
                if(cars.length >0) {
                  for (int i = carId; i <= cars.last.id; i++) {
                    //cars[i].id--;
                    var result = await http_post("REdit-car", {
                      "id": cars[i].id--,
                      "make": cars[i].make,
                      "model": cars[i].model,
                      "licencePlate": cars[i].licencePlate,
                    });
                    if(result.ok)
                    {
                      setState(() {
                        response = result.data['status'];
                      });
                    }
                  }
                }
                Navigator.pop(context,);
              },
              heroTag: null,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: Icon(
                  Icons.edit
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute( builder: (context) => PostEditPage(carId))).then((_) => setState(() {refreshCars().then((value){
                print('Async done');
              });})),
              heroTag: null,
            ),

            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  // указываем имя pony
                  "Make: "+car.make,
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
                )
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Model: "+car.model,
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
                )
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "LicencePlate: "+car.licencePlate,
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),
                )
            )
          ],
        ),
      ),

    );
  }
}