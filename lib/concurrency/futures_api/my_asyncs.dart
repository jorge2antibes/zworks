import 'dart:async';

///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///
/// my own
void main() async {

  final streamOfNumbers = optionalMap(numbers(),);
  await for (final number in streamOfNumbers){
    print(number);
  }

  print('---------------------');

  final anotherStreamOfNumbers = optionalMap(numbers(), multiplyByTwo);
  await for (final number in anotherStreamOfNumbers){
    print(number);
  }

  print('---------------------');

  final numbersToThemeselves = numbers().listen((event) {
    print('listening event: $event');
  });

}

//* When this function is called, it immediately returns a Stream<T> object.
//* Then nothing further happens until someone tries to consume that stream.
//* At that point, the body of the async* function starts running. If the
//* convert function was omitted, the yield* will listen to the source stream
//* and forward all events, date and errors, to the returned stream. When the
//* source stream closes, the yield* is done, and the optionalMap function body
//* ends too. This closes the returned stream. If a convert is supplied, the
//* function instead listens on the source stream and enters an await for loop
//* which repeatedly waits for the next data event. On a data event, it calls
//* convert with the value and emits the result on the returned stream. If no
//* error events are emitted by the source stream, the loop ends when the source
//* stream does, then the optionalMap function body completes, which closes the
//* returned stream. On an error event from the source stream, the await for
//* re-throws that error, which breaks the loop. The error then reaches the end
//* of the optionalMap function body, since it's not caught. That makes the error
//* be emitted on the returned stream, which then closes.
Stream<T> optionalMap<T>(Stream<T> source, [T Function(T)? convert]) async* {

  if (convert == null){
    yield* source;
  } else {
    await for (var event in source){
      yield convert(event);
    }
  }
}

Stream<int> numbers() async* {
  yield 1;
  yield 2;
  yield 3;
  yield 4;
  yield 5;
}

int multiplyByTwo(int value){
  return value * 2;
}