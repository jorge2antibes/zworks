/// Synchronous example
// String createOrderMessage() {
//   var order = fetchUserOrder();
//   return 'Your order is: $order';
// }
//
// Future<String> fetchUserOrder() =>
//     // Imagine that this function is
// // more complex and slow.
// Future.delayed(
//   const Duration(seconds: 2),
//       () => 'Large Latte',
// );
//
// void main() {
//   print('Fetching user order...');
//   print(createOrderMessage());
// }

/// Asynchronous example
Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

/// Asynchronous programming: futures, async, await
/// https://dart.dev/libraries/async/async-await
Future<void> main() async {
  print('Fetching user order...');

  /// asynchronous ok
  /// The asynchronous example is different in three ways:
  ///
  /// The return type for createOrderMessage() changes from String to Future<String>.
  /// The async keyword appears before the function bodies for createOrderMessage() and main().
  /// The await keyword appears before calling the asynchronous functions fetchUserOrder() and createOrderMessage()
  print(await createOrderMessage());
}
