main(List<String> arguments) {
  final foo = Foo();
  print(foo.privateClass.publicFoo);
  print(foo.privateClass._privateBar); // invalid because of ._privateBar
}

class Foo {
  final _PrivateClass privateClass = _PrivateClass();
}

class _PrivateClass {
  String publicFoo = 'foo';
  String _privateBar = 'bar';
}
