// This example shows how *not* to write asynchronous Dart code.

String createOrderMessage() {
  var order = fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
Future.delayed(
  const Duration(seconds: 2),
      () => 'Large Latte',
);

/// The following example shows the wrong way to use an asynchronous function (fetchUserOrder()). Later you'll fix t
/// he example using async and await. Before running this example, try to spot the issue -- what do you think the
/// output will be?
/// https://dart.dev/libraries/async/async-await
///
/// Here's why the example fails to print the value that fetchUserOrder() eventually produces:
///
///fetchUserOrder() is an asynchronous function that, after a delay, provides a string that describes the user's
///order: a "Large Latte".
///
///To get the user's order, createOrderMessage() should call fetchUserOrder() and wait for it to finish. Because
/// createOrderMessage() does not wait for fetchUserOrder() to finish, createOrderMessage() fails to get the
/// string value that fetchUserOrder() eventually provides.
///
///Instead, createOrderMessage() gets a representation of pending work to be done: an uncompleted future.
///You'll learn more about futures in the next section.
///
///Because createOrderMessage() fails to get the value describing the user's order, the example fails
///to print "Large Latte" to the console, and instead prints "Your order is: Instance of '_Future<String>'"
void main() {
  print(createOrderMessage());
}