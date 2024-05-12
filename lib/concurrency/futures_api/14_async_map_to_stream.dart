import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// streams transformed using async expand.
void main() async {
  final names3Times = namesGenerator().asyncExpand(
    (name) => times3(name),
  );
  await for (final name in names3Times){
    print('name: $name');
  }
}

Stream<String> namesGenerator() {
  final nameList = [
    'name1',
    'name2',
    'name3',
  ];
  final names = Stream.periodic(const Duration(milliseconds: 500), (index) => nameList[index]).take(nameList.length);
  // final names = Stream.periodic(Duration(seconds: 1), (index) => nameList[index]);//without take() throws out of range exception
  return names;
}

Stream<String> times3(String str) => Stream.fromIterable(
      Iterable<String>.generate(
        3,
        (index) => str,
      ),
    );
