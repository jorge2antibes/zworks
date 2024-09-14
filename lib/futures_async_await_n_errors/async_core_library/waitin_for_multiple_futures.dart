Future<void> aFuture() {
  print('aFuture() starts');
  return Future<void>.delayed(Duration(seconds: 1), () {
    print('aFuture() is done');
  });
}

Future<void> anotherFuture() {
  print('anotherFuture() starts');
  return Future<void>.delayed(Duration(seconds: 2), () {
    print('anotherFuture() is done');
  });
}

Future<void> yetAanotherFuture() {
  print('yetAanotherFuture() starts');
  return Future<void>.delayed(Duration(seconds: 4), () {
    print('yetAanotherFuture() is done');
  });
}

Future<int> yetAanotherFutureWValue() {
  print('yetAanotherFutureWValue() starts');
  return Future<int>.delayed(Duration(seconds: 6), () {
    print('yetAanotherFutureWValue() is done');
    return 777;
  });
}

///Futures does not necessary have to share the same returned type
void main() async {
  try {
    await Future.wait([
      aFuture(),
      anotherFuture(),
      yetAanotherFuture(),
      yetAanotherFutureWValue(),
    ]);
  } catch (err) {
    print(err.toString());
  }
}
