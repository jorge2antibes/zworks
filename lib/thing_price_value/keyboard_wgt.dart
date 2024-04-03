import 'package:flutter/material.dart';


///Solution from:
///
///https://www.kindacode.com/article/flutter-dismiss-keyboard-when-tap-outside-text-field/
///https://flutterigniter.com/dismiss-keyboard-form-lose-focus/
///
///Full explanation at:
///
///https://docs.flutter.dev/development/ui/advanced/focus
///
class KeyboardWgt extends StatelessWidget {
  const KeyboardWgt({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        // if (!currentFocus.hasPrimaryFocus ) {
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }

  ///Dismiss the keyword when tapped outside the keyboard
  static void dismiss(BuildContext context) {

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus ) {
    // if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

  }
}
