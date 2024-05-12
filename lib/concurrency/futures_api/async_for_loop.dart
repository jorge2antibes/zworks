import 'dart:async';

///https://github.com/dart-lang/sdk/issues/49504
/// This program prints 1 - 4 and finishes. I do understand why code after
/// await for(...) {...} is not executed. Stream, controlled by StreamController,
/// is not closed and await for waits for it. If we want this code to be
/// executed we should change the program to be like the following (right after //)
// void main() async {
//   final sc = StreamController<String>();
//   final stream = generator();
//   sc.addStream(stream);
//   await for (final name in sc.stream) {
//     print('sc.stream: $name');
//   }
//   print('now we are here');
//   throw Exception('Bom!!!');
// }

// Conclusion:
// As @eernstg says, the first example is a classical example of a stuck/deadlocked
// asynchronous program.
// The await for waits for the stream to close. The stream does not close. So the
// await for never completes.
// The program stops doing things, because there is nothing left to do, and
// that's the definition of a program terminating.
// It just exits, like any other program which has no scheduled events or
// timers or open ports, and no code running. Nothing is happening, and nothing
// can ever happen again, so the main isolate terminates.
// The await for looks like straight-line code, but it's actually based on callbacks,
// and if that callback is never invoked, nobody will complain.
// It is rather surprising, though, and it has been suggested before that keeping
// the isolate alive, with an option to see it hanging at the await for in the debugger,
// would be better than just silently terminating without even running finally blocks.
// This is basically a duplicate of #24895. which itself refers to the general issue #23797.
void main() async {
  final sc = StreamController<String>();
  final stream = generator();
  sc.addStream(stream).then((_) {
    print('then().value: $_');
    print('sc.isCloused(): ${sc.isClosed}');
    sc.add('name4');
    sc.close();
    print('sc.isCloused(): ${sc.isClosed}');
  });
  await for (final name in sc.stream) {
    print('sc.stream: $name');
  }
  print('now we are here');
  throw Exception('Bom!!!');
}

Stream<String> generator() {
  final names = <String>[
    'name1',
    'name2',
    'name3',
  ];

  final stream = Stream<String>.periodic(
    const Duration(seconds: 1),
    (computationCount) => names[computationCount],
  ).take(names.length);

  return stream;
}
