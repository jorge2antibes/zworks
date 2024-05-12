import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// streams transformed using async map. transform every element from stream into a future
void main() async {
  //???
  // final names = namesGenerator();
  // final controller = StreamController<String>();
  // controller.addStream(names);
  //
  // await for (final name in controller.stream){
  //   print('name: $name');
  // }
  // print('___does not reach here_________');

  final stream = namesGenerator();
  await for (final name in stream) {
    print('name: $name');
  }
  print('______reach here, though blocking i.e. waiting for await to resolve------');

  final stream1 = namesGenerator();
  final result = stream1.asyncMap((name) => characterize(name));
  await for (final charList in result) {
    print('charList: $charList');
    for (final char in charList) {
      print('char: $char');
    }
  }

  print('_________another blocking solution (cleaner)');

  final stream2 = namesGenerator();
  final characterized = await stream2.asyncMap((str) => characterize(str)).fold('', (previous, element) {
    final elements = element.join(' ');
    return '$previous $elements';
  });

  print('characterized: $characterized');

  print('_________Non blocking solution (cleaner)');

  final stream3 = namesGenerator();
  final characterized3 = stream3.asyncMap((str) => characterize(str)).fold('', (previous, element) {
    final elements = element.join(' ');
    print('previous: $previous');
    print('element: $element');
    print('elements: $elements');
    return '$previous $elements';
  }).then((characterized) => print('characterized: $characterized'));

  print('synchronous characterized is just the future un resolved: $characterized3');
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

Future<List<String>> characterize(String str) async {
  final characters = <String>[];
  for (final char in str.split('')) {
    await Future.delayed(
      const Duration(milliseconds: 100),
      () => characters.add(char),
    );
    // await Future.delayed(const Duration(milliseconds: 500));
    // characters.add(char);
  }
  return characters;
}

List<String> characterizeWithoutFuture(String str) {
  final characters = <String>[];
  for (final char in str.split('')) {
      () => characters.add(char);
  }
  return characters;
}
