import 'package:flutter/material.dart';
import 'package:flutter_mvvm/home/my_home_view_model.dart';
import 'package:provider/provider.dart';

import 'home/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var model = MyHomeViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MyHomeViewModel>(
        create: (BuildContext context) => MyHomeViewModel(),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
