// https://medium.com/flutter-community/exploring-mixins-in-dart-flutter-43514cd9952b#:~:text=you%20already%20did.-,mixin%20is%20a%20way%20to%20reuse%20code%20by%20allowing%20classes,%2Da%20relationship)%20does%E2%80%9D.
// How is different?
// Now check out the following definitions to get more insight.
//
// is-a Relationship : It can be defined as direct relationship between two class where one class
// (lets say Class B) is subclass of other class (lets say Class A). Which is called as INHERITANCE.
//
// — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — —
//
// has-a Relationship: It can be defined as an association between two classes where one
// class (let’s say Class A) contains an instance of another class (let’s say Class B) as one
// of its members. This association allows Class A to have access to the functionalities and
// properties of Class B, thus known as COMPOSITION.
//
// A Pixel phone 'is a' mobile phone and 'it has' a Camera and 'it has' a Wifi instances

class Mobile {}

class Wifi {}

class Camera {}

// Subclass or child class
// example of 'is a' relationship
class Pixel extends Mobile {

  //example of 'has a' relationship
  final Wifi wifi = Wifi();
  //example of 'has a' relationship
  final Camera camera = Camera();
}

//mixin is a way to reuse code by allowing classes to inherit behaviours and properties from multiple
// sources, “without establishing a strict hierarchy of parent child relationship which is what
// inheritance (is-a relationship) does”.

// So classes using mixin can inherit all properties and functions but cannot be termed as subclass.
//
// why????
//
// Because mixins establish a relationship similar to, but not exactly, a “has-a” relationship between
// a class and the functionalities provided by the mixin. It gains access to the methods and
// properties defined in the mixin.
//
// However, the difference is the class itself doesn’t hold an instance of the mixin; rather,
// it just inherits it. There’s no strict hierarchy involved. So as it is not being bound by a
// strict hierarchy of parent-child relationships.
//
// This flexibility allows classes to benefit from the functionalities provided by mixins
// without forming a direct “is-a relationship” with them.


