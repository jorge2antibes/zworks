///Streans
///
/// future => | ........... 1s ......... X |
/// stream => | ........... 1s ......... X ..... 500ms ..... X ........ 700ms....... XXX ..... and so on |
///https://www.youtube.com/watch?v=-zNC2hWftho&list=RDCMUC8NpGP0AOQ0kX9ZRcohiPeQ&index=10
/// asynchronous generators part 1
void main() async {
  await for (final number in getNumbers()) {
    print(number);
  }

  print('-------------------');

  await for (final number in getNumbers(start: 3, end: 13)) {
    print(number);
  }

  print('-------------------');

  await for (final number in getNumbers(start: 3, end: 13, func: (value) => evenNumber(value))) {
    print(number);
  }

  print('-------------------');

  await for (final number in getNumbers(start: 3, end: 13, func: (value) => oddNumber(value))) {
    print(number);
  }
}

typedef Included = bool Function(int value);

bool evenNumber(int value) => value.isEven;

bool oddNumber(int value) => value.isOdd;

Stream<int> getNumbers({int start = 1, int end = 10, Included? func}) async* {
  for (start; start < end; start++) {
    if (func == null || func(start)) {
      yield start;
    } else {
      yield 99;
    }
    yield 111;
  }
  yield 0;
}
