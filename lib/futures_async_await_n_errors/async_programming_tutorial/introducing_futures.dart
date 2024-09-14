Future<void> fetchUserOrder() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

/// Asynchronous programming: futures, async, await
/// https://dart.dev/libraries/async/async-await
void main() {
  fetchUserOrder();
  print('Fetching user order...');
}
