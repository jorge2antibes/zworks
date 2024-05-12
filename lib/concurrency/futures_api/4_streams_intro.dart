///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
void main() async {

  await for (final number in getNumbers()) {
    print(number);
  }

  try {
    await for (final name in getNames()){
      print(name);
    }
  } catch (e){
    print(e);
  }
}

//* creates a stream with async* that allows to use the yield keyword. In the other hand
//* async (without *) will only allow us to use await keyboard
Stream<int> getNumbers() async* {
  for (var i = 0; i < 3; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i; //returns the value within the Stream
  }
}

Stream<String> getNames() async* {
  await Future.delayed(const Duration(seconds: 1));
  yield 'Jorge';
  throw Exception('something went wrong');
  yield 'Dieguez';
}
