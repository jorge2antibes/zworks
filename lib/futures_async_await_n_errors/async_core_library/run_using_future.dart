void main() {
  runUsingFuture();
}

void runUsingFuture() {
  print('runUsingFuture()');
  getTheString()
      .then(
        (theString) => runExecutable(theString, []),
      )
      .then(flushThenExit);
  print('runUsingFuture() done');
}

Future<String> getTheString() {
  print('getTheString()');
  return Future<String>.delayed(
    Duration(seconds: 3),
    () {
      print('getTheString() done');
      return '777';
    },
  );
}

Future<int> runExecutable(String entryPoint, List<String> args) {
  print('RunExecutable()');
  return Future<int>.delayed(
    Duration(seconds: 2),
    () {
      print('runExecutable() done');
      return int.parse(entryPoint);
    },
  );
}

Future<void> flushThenExit(int exitCode) {
  print('flushThenExit()');
  return Future<void>.delayed(
    Duration(seconds: 3),
    () => print('flushThenExit() done'),
  );
}
