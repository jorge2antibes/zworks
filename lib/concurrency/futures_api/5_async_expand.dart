///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// async expand
void main() async {

  final charStream = getNames().asyncExpand((nameOrSurname) => getCharacters(nameOrSurname));
  await for (final c in charStream){
    print(c);
  }



}

Stream<String> getCharacters(String s) async* {
  for (var i = 0; i < s.length; i++){
    await Future.delayed(const Duration(milliseconds: 300));
    yield s[i];
  }
}

Stream<String> getNames() async* {
  await Future.delayed(const Duration(milliseconds: 200));
  yield 'Jorge';
  await Future.delayed(const Duration(milliseconds: 200));
  yield 'Dieguez';
}

