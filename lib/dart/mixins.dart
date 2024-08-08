void main() {
  final c = C();
  final d = SuperPowers();
  d.aSuperPowersMethod();

  print('C is Super: ${c is Super}');
  print('C is SuperPowers: ${c is SuperPowers}');
  print('C is MixinPowers: ${c is MixinPowers}');
}

class C extends Super {}

class Super extends SuperPowers {}

class SuperPowers {
  void aSuperPowersMethod(){
    print('aSuperPowerMethod(): called');
  }
}

mixin MixinPowers on SuperPowers {
  void aMixinMethod(){
    print('aMixinMethod(): called');
  }
}
