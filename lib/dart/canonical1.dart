// https://dart.dev/language/mixins
//Specify members a mixin can call on itself
// Sometimes a mixin depends on being able to invoke a method or access fields, but can't define
// those members itself (because mixins can't use constructor parameters to instantiate their own fields).
// The following sections cover different strategies for ensuring any subclass of a mixin defines any members
// the mixin's behavior depends on.
// Define abstract members in the mixin
// Declaring an abstract method in a mixin forces any type that uses the mixin to define the abstract method
// upon which its behavior depends.

mixin Musician {

}

class Virtuoso with Musician {
  
}