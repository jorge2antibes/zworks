Future<void> aFuture() {
  print('aFuture() starts');
  return Future<void>.delayed(Duration(seconds: 3), () {
    print('aFuture() is done');
  });
}

Future<void> anotherFuture() {
  print('anotherFuture() starts');
  return Future<void>.delayed(Duration(seconds: 3), () {
    print('anotherFuture() is done');
  });
}

Future<void> yetAanotherFuture() {
  print('yetAanotherFuture() starts');
  return Future<void>.delayed(Duration(seconds: 3), () {
    print('yetAanotherFuture() is done');
  });
}

void main() async {
  try {
    await aFuture();
    await anotherFuture();
    await yetAanotherFuture();
  } catch (err) {
    print(err.toString());
  }
}
