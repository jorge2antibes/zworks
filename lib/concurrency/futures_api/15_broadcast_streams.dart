import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// broadcast streams
void main() async {
  print(('0 leg'));
  await nonBroadcastStream0();

  print('after controller0 cancelled, the code flow can continue... as follows');

  await nonBroadcastStream1();

  //* this is just an exaple of synchronous call to in-act the stream, and it works well, just it interleaves
  //* the results from the stream with other examples
  // nonBroadcaseStream2();

  print('now comes broadcast streams');

  await BroadCastStream3();
}

//* these methods return future so I execute each example in a synchronous way i.e. example after example, by
//* using async keyboard I can use await keyboard to return only after the stream is consume.
Future<void> nonBroadcastStream0() async {
  final controller0 = StreamController<String>();
  //? onCancel is a property that expects a () =>{}. (it is not a function)
  controller0.onCancel = () => print('Stream0 is being closed');
  //? controller0.add() is equivalent to controller0.sink.add()
  controller0.add('name01');
  controller0.add('name02');
  controller0.add('name03');
  controller0.sink.add('name04');
  controller0.sink.add('name05');
  controller0.sink.add('name06');
  controller0.close();

  try {
    await for (final name in controller0.stream) {
      print('name: $name');
      //! e: Bad state: Stream has already been listened to.
      // await for (final name in controller0.stream) {
      //   print('name: $name');
      // }
    }
  } catch (e) {
    print('e: $e');
  }
}

Future<void> nonBroadcastStream1() async {
  final controller1 = StreamController<String>();
  final subsc1 = controller1.stream.listen(
    (event) {
      print('controller1.stream.listen(): event: $event');
    },
    onDone: () => print('subsc1.onDone(): done!'),
    onError: (e) => print('subc1.onError(): $e'),
  );
  subsc1.onData((data) => print('subsc1.onData(): $data, replaces .listen()'));
  subsc1.onDone(() => print('subsc1.onDone(): done!, replaces .listen(onDone)'));
  subsc1.onError((e) => print('subsc1.onError(): $e, replaces .listen(onError)'));
  controller1.onCancel = () async {
    print('controller1.onCancel: called');
    subsc1.cancel();
  };
  controller1.onResume = () => print('controller1.onResume: called');
  controller1.onPause = () => print('controller1.onPause: called');
  controller1.onListen = () => print('controller1.onListen: called');
  controller1.sink.add('name11');
  controller1.sink.add('name12');
  controller1.sink.add('name13');
  //? this await makes sense in the context of nonBroadcastStream1() because it makes
  //? the method to return only when close() future return i.e. after draining the stream
  //? off events. Otherwise, the program run the rest of examples interleaved with this
  //? stream.
  await controller1.close();

  //! Bad state: Stream has already been listened to.
  // final subsc2 = controller1.stream.listen((event) {
  //   print('event: $event');
  // });
}

void nonBroadcaseStream2() {
  final controller2 = StreamController<String>();
  final subsc2 = controller2.stream.listen(
    (event) {
      print('controller2.stream.listen(): event: $event');
    },
    onDone: () => print('subsc2.onDone(): done!'),
    onError: (e) => print('subc1.onError(): $e'),
  );
  subsc2.onData((data) => print('subsc2.onData(): $data, replaces .listen()'));
  subsc2.onDone(() => print('subsc2.onDone(): done!, replaces .listen(onDone)'));
  subsc2.onError((e) => print('subsc2.onError(): $e, replaces .listen(onError)'));
  controller2.onCancel = () async {
    print('controller2.onCancel: called');
    subsc2.cancel();
  };
  controller2.onResume = () => print('controller2.onResume: called');
  controller2.onPause = () => print('controller2.onPause: called');
  controller2.onListen = () => print('controller2.onListen: called');
  controller2.sink.add('name21');
  controller2.sink.add('name22');
  controller2.sink.add('name23');
  controller2.close();

  //! Bad state: Stream has already been listened to.
  // final subsc2 = controller2.stream.listen((event) {
  //   print('event: $event');
  // });
}

//* To notice that this single broadcast controller can be listen to more than once.
//* Also notice that I'm overriding the controller onDone() as I could have do with onError()
Future<void> BroadCastStream3() async {
  final controller3 = StreamController<String>.broadcast();
  final subsc30 = controller3.stream.listen(
    (event) {
      print('subsc30.listen(): event: $event');
    },
    onDone: () => print('controller3.stream.listen():onDone is done'),
  );
  //* replace the previos subscription onDone with this
  subsc30.onDone(() {
    print('subsc30.onDone: controller3.stream.listen(): onDone overriden!!!');
  });

  final subsc31 = controller3.stream.listen(
    (event) {
      print('subsc31.listen(): event: $event');
    },
    onDone: () => print('controller3.stream.listen():onDone is done'),
  );
  controller3.onCancel = () {
    print('controller3.onCancel: cancelling subscriptions...');
    subsc30.cancel();
    subsc31.cancel();
  };

  controller3.sink.add('name31');
  controller3.sink.add('name32');
  controller3.sink.add('name33');

  await controller3.close();
}
