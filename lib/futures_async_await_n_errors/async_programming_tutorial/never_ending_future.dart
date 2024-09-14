

import 'dart:async';
/// No exceptions or errors are displayed along with the early exit (even when setting the
/// debugger breakpoints for 'All Exceptions' and 'Uncaught Exceptions' to true), which
/// means that any non-completing future will cause a silent failure that is extremely
/// difficult to debug.
/// https://github.com/dart-lang/sdk/issues/51462
void main() async {
  print('start program');
  await neverEndingCompleter.future;
  print('main() has completed');
}

final neverEndingCompleter = Completer<bool>();