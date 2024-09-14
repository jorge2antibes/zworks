Future<void> fetchUserOrder() {
  // Imagine that this function is fetching user info but encounters a bug.
  return Future.delayed(
    const Duration(seconds: 2),
    () => throw Exception('Logout failed: user ID is invalid'),
  );
}

/// Asynchronous programming: futures, async, await
/// https://dart.dev/libraries/async/async-await
void main() {
  fetchUserOrder();
  print('Fetching user order...');
}
