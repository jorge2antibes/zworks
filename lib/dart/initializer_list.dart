// The layout source-code is usually complex, so it's probably better to just read the documentation. However,
// if you decide to study the layout source-code, you can easily find it by using the navigating capabilities of your IDE.
// Here's an example:
// Find a Column in your code and navigate to its source code. To do this, use command+B (macOS) or control+B (Windows/Linux)
// in Android Studio or IntelliJ. You'll be taken to the basic.dart file. Since Column extends Flex, navigate to the Flex
// source code (also in basic.dart).
// Scroll down until you find a method called createRenderObject(). As you can see, this method returns a RenderFlex. This
// is the render-object for the Column. Now navigate to the source-code of RenderFlex, which takes you to the flex.dart file.
// Scroll down until you find a method called performLayout(). This is the method that does the layout for the Column

void main() {}

class AClass {
  AClass({
    List<String>? children,
    int anInt = 2,
    String anString = 'anString'
  }) : _anInt = anInt,
  _anString = anString
  {
    // addAll(children);
  }

  int _anInt;
  String _anString;
}


