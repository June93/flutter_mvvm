class MyHomeApi {
  int _count = 0;

  Future<int> addCount() async {
    await Future.delayed(Duration(seconds: 1), () {
      _count++;
    });
    return _count;
  }
}
