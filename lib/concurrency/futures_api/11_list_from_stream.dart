import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// creating list from stream
void main() async {
  final nameStream0 = names1();
  final namesList0 = await nameStream0.toList();//blocks the rest of the execution during 3 * 1000 ms
  print('names0: $namesList0');

  print('____________________');

  final nameStream = names1();
  var val;
  nameStream.toList().then((value) {//this approach does not block
    val = value;
    print('val: $val');
  });
  print('continuing...');

  print('____________________');

  final nameString1 = names1();
  await for (final name in nameString1) {
    print(name);
  }
  // final namesList1 = await nameString1.toList();
  // print('names1: $namesList1');
}

Stream<String> names0() async* {
  yield 'Mario';
  yield 'Ramom';
  yield 'ana';
}

Stream<String> names1() {
  final names = [
    'juan',
    'anibal',
    'hector',
  ];
  // return Stream<String>.periodic(Duration(milliseconds: 10000), (eventIndex) => eventIndex.toString());
  return Stream<String>.periodic(const Duration(milliseconds: 1000), (eventIndex) => names[eventIndex]).take(names.length);
}
