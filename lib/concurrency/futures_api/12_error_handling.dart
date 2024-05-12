import 'dart:async';


///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// streams error handling
void main() async {
  // absorbes but block code execution afterwards
  // final names0;
  // names0 = names1WithException().absorbeErrorsUsingHandleError();
  // await for (final name in names0){
  //   print(name);
  // }

  // absorbes but block code execution afterwards
  // print('----------------');
  // //same as above
  // final names2 = names1WithException().handleError((e, stacktrace) {});
  // await for (final name in names2) {
  //   print(name);
  // }

  //does not block the program execution
  // final names1 = names1WithException().absorbeErrorsUsingHandlers());
  // await for (final name in names1) {
  //   print(name);
  // }

  final stream = names1();
  // final sc = StreamController<String>();
  // sc.addStream(stream);
  // stream.transform(streamTransformer)
  // stream.absorbeErrorsUsingTransformer();//throw already listened to!!!
  late final StreamSubscription subscription;
  subscription = stream.listen(
    (event) => print('onListen(): $event'),
    onDone: () => print('onDone()'),
    cancelOnError: false,
    onError: (err, stacktrace) async {
      print('onError(): $err');
      await Future.delayed(const Duration(seconds: 1));
      subscription.pause();
      await Future.delayed(const Duration(seconds: 1));
      subscription.resume();
      await Future.delayed(const Duration(seconds: 1));
      subscription.pause();
      await Future.delayed(const Duration(seconds: 1));
      subscription.cancel();
    },
  );

  await for (final name in names1().absorbeErrorsUsingTransformer()){
    print('name: $name');
  }
}

Stream<String> names1WithException() {
  final names = [
    'juan',
    'anibal',
    'hector',
  ];
  // return Stream<String>.periodic(Duration(milliseconds: 1000), (eventIndex) => names[eventIndex]).take(4);//thows execption: value not in range
  // return Stream<String>.periodic(Duration(milliseconds: 1000), (eventIndex) => names[eventIndex]).take(names.length);
  return Stream<String>.periodic(const Duration(milliseconds: 1000), (eventIndex) => eventIndex < names.length - 1 ? names[eventIndex] : throw 'Out of names').take(names.length);
}

Stream<String> names1() {
  final names = [
    'juanB',
    'anibalB',
    'hectorB',
  ];
  // return Stream<String>.periodic(Duration(milliseconds: 1000), (eventIndex) => names[eventIndex]).take(4);//thows execption: value not in range
  // return Stream<String>.periodic(Duration(milliseconds: 1000), (eventIndex) => names[eventIndex]).take(names.length);
  return Stream<String>.periodic(const Duration(milliseconds: 1000), (eventIndex) => names[eventIndex]);
}

extension AbsorbeErrors<T> on Stream<T> {
  Stream<T> absorbeErrorsUsingHandleError() => handleError(
        (o, stacktrace) {}, //absorves the error but blocks the program execution
      );

  Stream<T> absorbeErrorsUsingHandlers() => transform(
        StreamTransformer.fromHandlers(
          handleError: (o, stacktrace, eventSink) => eventSink.close(),
        ),
      );

  Stream<T> absorbeErrorsUsingTransformer() => transform(
        StreamErrorAbsorber(),
      );
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    final controller = StreamController<T>();
    stream.listen(
      controller.sink.add,
      onError: (err) {},
      onDone: controller.close,
    );

    return controller.stream;
  }
}
