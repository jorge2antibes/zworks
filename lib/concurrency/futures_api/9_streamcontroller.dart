
import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// stream controllers. Object that allow to sink events into the stream and read events from the stream
void main() async {
  final controller = StreamController();
  controller.sink.add('Hello');
  controller.sink.add('world');

  await for (final value in controller.stream){
    print('value: $value');
  }
  controller.close();//no further events can be added to the stream
}
