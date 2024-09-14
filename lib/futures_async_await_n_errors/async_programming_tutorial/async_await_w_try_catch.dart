Future<void> printOrderMessage() async {
  try {
    print('Awaiting user order...');
    var order = await fetchUserOrder();
    print(order);
  } catch (err) {
    print('Caught error: $err');
  }
}

Future<String> fetchUserOrder() {
  // Imagine that this function is more complex.
  var str = Future.delayed(
      const Duration(seconds: 4),
          () => throw 'Cannot locate user order');
  return str;
}

/// Asynchronous programming tutorial
/// https://dart.dev/libraries/async/async-await
void main() async {
  await printOrderMessage();
}