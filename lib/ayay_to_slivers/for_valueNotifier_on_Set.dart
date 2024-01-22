import 'package:flutter/foundation.dart';
import 'package:sbox1/ayay_to_slivers/ayay2.dart';

void main() {
  var vs = ValueState(<Thing>{Thing(id: 0), Thing(id: 1)});
  print('create vs');
  vs.addListener(() {
    for (var thing in vs.value) {
      print('Listener was notified: vs.value: thing: ${thing.id}');
    }
  });

  Future.delayed(
    Duration(seconds: 2),
    () => vs.doSomething(),
  );
  Future.delayed(
    Duration(seconds: 4),
    () => vs.doSomethingElse(),
  );
  Future.delayed(
    Duration(seconds: 6),
    () => vs.doReplaceAtBegin(),
  );
  Future.delayed(
    Duration(seconds: 8),
    () => vs.doReplaceAtEnd(),
  );
}

mixin OnCollections<S extends Set<E>, E extends ImgPicked> on ValueNotifier<S> {
  void add(E e) {
    value.add(e);
    notifyListeners();
  }

  /// add a thing to MyThingsState at index and notifies MyThingsVw
  void addAt(int index, E e) {
    var l = value.toList();
    l.insert(index, e);
    value = Set<E>.of(l) as S;
  }

  void addOrReplaceAt(int index, E e) {
    if (value.isNotEmpty && index < value.length) {
      var eAt = value.elementAt(index);
      value.remove(eAt);
      var l = value.toList();
      l.insert(index, e);
      value = Set<E>.of(l) as S;
    } else {
      value.add(e);
      notifyListeners();
    }
  }

  /// remove a thing from MyThingsState and notifies MyThingsVw
  void remove(E e) {
    value.remove(e);
    notifyListeners();
  }

  /// remove a thing from MyThingsState at index and notifies MyThingsVw
  void removeAt(int index) {
    var e = value.elementAt(index);
    value.remove(e);
    notifyListeners();
  }
}

mixin OnCollectionsForValueNotifiers<S extends Set<E>, E extends Thing>
    on ValueNotifier<S> {
  void add(E e) {
    value.add(e);
    notifyListeners();
  }

  /// add a thing to MyThingsState at index and notifies MyThingsVw
  void addAt(int index, E e) {
    var l = value.toList();
    l.insert(index, e);
    value = Set<E>.of(l) as S;
  }

  void addOrReplaceAt(int index, E e) {
    if (value.isNotEmpty && index < value.length) {
      var eAt = value.elementAt(index);
      value.remove(eAt);
      var l = value.toList();
      l.insert(index, e);
      value = Set<E>.of(l) as S;
    } else {
      value.add(e);
      notifyListeners();
    }
  }

  /// remove a thing from MyThingsState and notifies MyThingsVw
  void remove(E e) {
    value.remove(e);
    notifyListeners();
  }

  /// remove a thing from MyThingsState at index and notifies MyThingsVw
  void removeAt(int index) {
    var e = value.elementAt(index);
    value.remove(e);
    notifyListeners();
  }
}

class Thing {
  final int id;

  Thing({required this.id});
}

class ValueState extends ValueNotifier<Set<Thing>>
    with OnCollectionsForValueNotifiers {
  ValueState(super.value);

  void doSomething() {
    var thing = Thing(id: 7);
    add(thing);
  }

  void doSomethingElse() {
    var thing = Thing(id: 777);
    addAt(1, thing);
  }

  void doReplaceAtEnd() {
    var thing = Thing(id: 999);
    addOrReplaceAt(3, thing);
  }

  void doReplaceAtBegin() {
    var thing = Thing(id: 999);
    addOrReplaceAt(0, thing);
  }
}
