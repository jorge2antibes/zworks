import 'package:flutter/foundation.dart';

void main() {
  var vs = ValueState(<Thing>{});
  print('create vs');
  vs.addListener(() {
    print('Listener was notified: vs.value: ${vs.value.first.id}');
  });

  Future.delayed(
    Duration(seconds: 3),
    () => vs.doSomething(),
  );
}

mixin ValueNotifierOnSet<S extends Set<E>, E> on ValueNotifier<S> {
  void add(E e) {
    value.add(e);
    notifyListeners();
  }
}

class Thing {
  final int id;

  Thing({required this.id});
}

class ValueState extends ValueNotifier<Set<Thing>> with ValueNotifierOnSet {
  ValueState(super.value);

  void doSomething() {
    var thing = Thing(id: 777);
    add(thing);
  }
}
