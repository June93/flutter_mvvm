import 'package:flutter/material.dart';

import 'my_home_api.dart';

class MyHomeViewModel with ChangeNotifier {
  int _count = 0;

  get count => _count;

  MyHomeApi api = MyHomeApi();

  //await实现方式
  addCount() async {
    _count = await api.addCount();
    notifyListeners();
  }

  //响应式实现方式
  rxAddCount() {
    Stream.fromFuture(api.addCount()).listen((count) {
      _count = count;
      notifyListeners();
    });
  }
}
