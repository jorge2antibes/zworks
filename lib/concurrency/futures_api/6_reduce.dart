///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// reduce
void main() async {

  int result = 0;
  print('at await for...');
  await for (final age in getAllAges()){
    print(age);
    result += age;
  }
  print('result: $result');

  print('--------------------');

  int result2 = 0;
  await getAllAges().reduce((previous, element) => result2 = sum2ints(previous, element));
  print('result2: $result2');


  print('--------------------');

  int result3 = 0;
  result3 = await getAllAges().reduce(sum2ints);
  print('result3: $result3');
}

int sum2ints(int a, int b) => a + b;

Stream<int> getAllAges() async* {
  yield 10;
  yield 20;
  yield 30;
  yield 40;
  yield 50;
}

