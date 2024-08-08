//@dart=2.19
class A {

  A();
}

//The class 'A' can't be used as a mixin because it declares a constructor. (Documentation)
// class B with A {}

// Common fixes:
//If is possible to convert the class to a mixin
mixin C {
  //mixins cannot declare constructors
  // C();
}

class B with C {}

//If the class can't be a mixin and it's possible to remove the constructor, then do so:
class D {
  //mixins cannot declare constructors
  // D();
}

class E with D {}
