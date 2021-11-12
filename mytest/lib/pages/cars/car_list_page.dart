import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytest/modules/http.dart';

import 'car_add_page.dart';
import 'car_detail_page.dart';

// класс машины, который будет хранить имя и описание, а также id
class Car {
  int id;
  final String make;
  final String model;
  final String licencePlate;

  Car(this.id,this.make, this.model, this.licencePlate);
}

// создаем список пони
// final указывает на то, что мы больше
// никогда не сможем присвоить имени ponies
// другой список поняшек
List<Car> cars = [
  //Car(0,"g","g","g")
];


// CarListPage не будет иметь состояния,
// т.к. этот пример создан только для демонстрации
// навигации в действии
class CarListPage extends StatefulWidget {
  const CarListPage({Key? key}) : super(key: key);
  @override
  State<CarListPage> createState() => _CarListPage();

}
class _CarListPage extends State<CarListPage> {


  Future<void> refreshCars()async{
    var result = await http_get('testcar');
    //log(result.data);
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


  void _addCar() {
    setState(() {
      //refreshCars;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //Navigator.pop(context,);
      //Navigator.push(context, MaterialPageRoute(
      //    builder: (context) => PostDetailPage()
      //));
      Navigator.push(context, MaterialPageRoute( builder: (context) => PostDetailPage())).then((_) => setState(() {refreshCars().then((value){
        print('Async done');
      });}));
      //Navigator.pop(context,);
    });
  }
  // build как мы уже отметили, строит
  // иерархию наших любимых виджетов
  @override
  @override
  void initState() {
    refreshCars().then((value){
      print('Async done');
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Car List")),
      // зададим небольшие отступы для списка
      body: RefreshIndicator(
          onRefresh: refreshCars,
          // объект EdgeInsets хранит четыре важные double переменные:
          // left, top, right, bottom - отступ слева, сверху, справа и снизу
          // EdgeInsets.all(10) - задает одинаковый отступ со всех сторон
          // EdgeInsets.only(left: 10, right: 15) - задает отступ для
          // определенной стороны или сторон
          // EdgeInsets.symmetric - позволяет указать одинаковые
          // отступы по горизонтали (left и right) и по вертикали (top и bottom)
          //padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          // создаем наш список
          child: ListView(
            // map принимает другую функцию, которая
            // будет выполняться над каждым элементом
            // списка и возвращать новый элемент (виджет Material).
            // Результатом map является новый список
            // с новыми элементами, в данном случае
            // это Material виджеты
            children: cars.map<Widget>((car) {
              // Material используется для того,
              // чтобы указать цвет элементу списка
              // и применить ripple эффект при нажатии на него
              return Material(
                color: Colors.pinkAccent,
                // InkWell позволяет отслеживать
                // различные события, например: нажатие
                child: InkWell(
                  // splashColor - цвет ripple эффекта
                  splashColor: Colors.pink,
                  // нажатие на элемент списка
                  onTap: () {
                    //refreshCars;
                    Navigator.push(context, MaterialPageRoute( builder: (context) => CarDetailPage(car.id))).then((_) => setState(() {refreshCars().then((value){
                      print('Async done');
                    });}));
                  },
                  // далее указываем в качестве
                  // элемента Container с вложенным Text
                  // Container позволяет указать внутренние (padding)
                  // и внешние отступы (margin),
                  // а также тень, закругление углов,
                  // цвет и размеры вложенного виджета
                  child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                                "Make: "+car.make+" Model: "+car.model+" LicencePlate: "+car.licencePlate,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)
                            )
                        ),
                      ]
                  ),
                ),
              );
              // map возвращает Iterable объект, который необходимо
              // преобразовать в список с помощью toList() функции
            }).toList(),
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addCar,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}