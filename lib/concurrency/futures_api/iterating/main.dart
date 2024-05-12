import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// stream controllers. Object that allow to sink events into the stream and read events from the stream
void main() async {
  final controller = StreamController<String>();
  controller.sink.add('Hello');
  controller.sink.add('J');
  controller.sink.add('o');
  controller.sink.add('r');
  controller.sink.add('g');
  controller.sink.add('e');

  // await for (final value in controller.stream){
  //   print('value: $value');
  // }

  var oneCharEventStream = controller.stream.where((event) {
    print('where(oneCharlong): event: $event');
    return event.length == 1;
  });

  var thingStream = oneCharEventStream.map<Thing>((event) {
    print('map() to int: $event');
    return Thing(char: event);
  });

  thingStream.listen((event) {
    print('Thing: thing.char: ${event.char}');
  });

  controller.close(); //no further events can be added to the stream
}

class Thing {
  final String char;

  Thing({required this.char});
}
