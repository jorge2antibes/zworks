import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// stream transformers
/// and steam from iterable
/// and extensions
void main() async {
  print('---------------');
  await for (final name in namesFromIterable()){
    print(name.toUpperCase());
  }
  print('---------------');
  await for (final name in namesFromIterable().map((name) => name.toUpperCase())){
    print(name);
  }

  print('---------------');
  final upperCasedNames = namesFromIterable().transform(ToUpperCase());
  await for (final name in upperCasedNames) {
    print('name transformed: $name');
  }

  print('---------------');
  final upperCasedNames2 = namesFromIterable().capitalize;
  await for (final name in upperCasedNames2){
    print('extesion capitalized with transform: $name ');
  }

  print('---------------');
  final upperCasedNames3 = namesFromIterable().capitalizeUsinMap;
  await for (final name in upperCasedNames3){
    print('extesion capitalized using map: $name ');
  }

  //from here is my own sandbox

  print('---------------');

  var subscription = namesFromIter.listen((event) {
    print(event.toUpperCase());
  });

  subscription.onData((data) {
    print('data: ${data.toUpperCase()}');
  });
  // subscription.pause();
  // subscription.resume();

  print('---------------');

  final namesFromContr = namesFromController(namesFromIter);
  final subscript = namesFromContr.listen((event) async {
    print('event: $event');
    await for (final ev in event) {
      print('ev: $ev');
    }
  });
}

extension on Stream<String> {
  Stream<String> get capitalize => transform(ToUpperCase());
  Stream<String> get capitalizeUsinMap => map((s) => s.toUpperCase());
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(  stream) {
    return stream.map((name) => name.toUpperCase());
  }

}

var namesFromIter = Stream<String>.fromIterable(
  ['jorge', 'daniel', 'peter'],
);

Stream<String> namesFromIterable() {
  return Stream.fromIterable([
    'leopoldo',
    'eugenio',
    'charles',
  ]);
}

Stream<Stream<String>> namesFromController(Stream<String> source) async* {
  final controller = StreamController<String>(
    onListen: onListen,
    onPause: onPause,
    onResume: onResume,
    onCancel: onCancel,
  );

  controller.sink.addStream(source);
  yield controller.stream;
}

void onListen() => print('stream is being listened to');

void onPause() => print('stream is paused');

void onResume() => print('stream is being resumed');

void onCancel() => print('stream is cancelled');
