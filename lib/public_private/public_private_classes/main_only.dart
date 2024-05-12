import 'classes.dart';

main(List<String> arguments) {
  final foo = Foo();
  print(foo.privateClass.publicFoo);
  // print(foo.privateClass._privateBar); // invalid because of ._privateBar
}
