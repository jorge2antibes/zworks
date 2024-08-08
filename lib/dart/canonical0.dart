class Musician extends Performer with Musical, JustAMixin {}

class AClass with JustAMixin {}

class Maestro extends Performer with Musical, Aggressive {
  final String name;
  final canConduct;

  Maestro(this.name, this.canConduct) {}

  @override
  void playsSomeMusic() {
    print('Musical: playsSomeMusic(); called');
  }

  void conducts() {
    print('Maestro: $name, conducts: $canConduct');
    print('Maestro: $name, compose: $canCompose');
  }
}

class Performer {
  void performs() {
    print('Performer: performs: called');
  }
}

mixin JustAMixin {
  void justAMethod() {
    print('JustAMixin: justAMethod() called');
  }
}

//as a mixin class
mixin class Musical {
  bool canConduct = false;
  bool canCompose = false;
  bool canPlayPiano = false;

  //this is a default constructor
  Musical();

  //The class 'Musical' can't be used as a mixin because it declares a constructor. (Documentation)
  // Musical(this.instrument);
  void playsSomeMusic() {
    print('Musical: playsSomeMusic(); called');
  }

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }

  void makeSomeMoney() {
    if (canCompose)
      print('Musical: makeSomeMoney(): by composing');
    else
      print('Musical: makeSomeMoney() but doing nothing');
  }
}

// Mixins and mixin classes cannot have an extends clause, and must not declare any generative constructors.
mixin Aggressive {
  void aggresses() {
    print('aggressive: aggresses(): called');
  }
}

// https://dart.dev/language/mixins
void main() {
  final aClass = AClass();
  print('AClass: is JustAMixin? : ${aClass is JustAMixin}');
  final musician = Musician();
  print('Musician: is Performer? : ${musician is Performer}');
  print('Musician: is Musical? : ${musician is Musical}');
  print('Musician: is JustAMixin? : ${musician is JustAMixin}');
  musician.canCompose = true;
  musician.entertainMe();
  musician.performs();
  musician.makeSomeMoney();
  musician.playsSomeMusic();
  musician.entertainMe();
  final maestro = Maestro('Chopin', true);
  maestro.makeSomeMoney();
  maestro.entertainMe();
  maestro.playsSomeMusic();
  maestro.conducts();
  maestro.aggresses();
}
