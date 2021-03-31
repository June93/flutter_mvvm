import 'dart:async';

class EventBus {
  // ignore: close_sinks
  late StreamController _streamController;

  //工厂构造函数
  factory EventBus() => _singleton;

  //保存单例
  static EventBus _singleton = new EventBus._internal();

  //私有构造函数
  EventBus._internal() {
    _streamController = StreamController.broadcast(sync: false);
  }

  //监听
  static observe<T>(void onData(T event)?,
      {Function? onError, void onDone()?, bool? cancelOnError}) {
    if (T == dynamic) {
      return _singleton._streamController.stream.listen(onData as dynamic,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    } else {
      return _singleton._streamController.stream
          .where((event) => event is T)
          .cast<T>()
          .listen(onData,
              onError: onError, onDone: onDone, cancelOnError: cancelOnError);
      ;
    }
  }

  //分发
  static void post(event) {
    _singleton._streamController.add(event);
  }

  //销毁
  static void destroy() {
    _singleton._streamController.close();
  }
}
