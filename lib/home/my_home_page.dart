import 'package:flutter/material.dart';
import 'package:flutter_mvvm/home/my_home_view_model.dart';
import 'package:flutter_mvvm/home/other_event.dart';
import 'package:provider/provider.dart';

import 'custom_event.dart';
import 'event_bus.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    EventBus.observe<CustomEvent>((event) {
      print("接受到自定义事件:CustomEvent");
      print("${EventBus() == EventBus()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "${Provider.of<MyHomeViewModel>(context).count}",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCount(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  addCount(BuildContext context) async {
    showLoading(context);
    await Provider.of<MyHomeViewModel>(context, listen: false).addCount();
    Navigator.pop(context);
    EventBus.post(CustomEvent());
    EventBus.post(OtherEvent());
  }

  void showLoading(context, [String? text]) async {
    var finalText = text ?? "Loading...";
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    //阴影
                    BoxShadow(
                      color: Colors.black12,
                      //offset: Offset(2.0,2.0),
                      blurRadius: 10.0,
                    )
                  ]),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              constraints: BoxConstraints(minHeight: 120, minWidth: 180),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      finalText,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
