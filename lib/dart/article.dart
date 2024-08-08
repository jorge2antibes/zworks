class APIService with MixinLogger {
  void getPosts() {
    final response = SomeClass();
  }
}

class SomeClass {}

mixin MixinLogger {
  void logMessage(String message) {
    print("MESSAGE: $message");
  }
}
///This article is wrong because it prints out: "APIService is of type MixinLogger" and no "APIService is not of type MixinLogger"
/// https://medium.com/flutter-community/exploring-mixins-in-dart-flutter-43514cd9952b#:~:text=you%20already%20did.-,mixin%20is%20a%20way%20to%20reuse%20code%20by%20allowing%20classes,%2Da%20relationship)%20does%E2%80%9D.
void main() {
  APIService apiService = APIService();

  if (apiService is MixinLogger) {
    print("APIService is of type MixinLogger");
  } else {
    print("APIService is not of type MixinLogger");
  }
}
