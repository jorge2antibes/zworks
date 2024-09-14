void main() {
  runUsingAwait();
}

Future<void> runUsingAwait() async {
  print('runUsingAwait()');
  var theString = await getTheString();
  var theCode = await runExecutable(theString, []);
  await flushThenExit(theCode);
  print('runUsingAwait() done');
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
