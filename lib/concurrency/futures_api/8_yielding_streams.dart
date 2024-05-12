///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// asynchronous generators part 2. Yielding Streams
void main() async {

  await for (final name in allNames()){
    print(name);
  }

  await for (final name in allNames2()){
    print(name);
  }
}

Stream<String> maleNames() async*{
  yield 'jorge';
  yield 'antonio';
  yield 'juan';
}

Stream<String> femaleNames() async*{
  yield 'amaya';
  yield 'patricia';
  yield 'elisia';
}

Stream<String> allNames() async* {

  await for (final name in femaleNames()){
    yield name;
  }

  await for (final name in maleNames()){
    yield name;
  }
}

Stream<String> allNames2() async* {

  yield* femaleNames();
  yield* maleNames();

}
