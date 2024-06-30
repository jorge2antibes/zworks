import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

extension ControllerExt on AnimationController {
  void repeatEx({required int times}) {
    var count = 0;
    addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (++count < times) {
          reverse();
        }
      } else if (status == AnimationStatus.completed) {
        forward();
      }
    });
  }
}

extension AlignItExt on AlignIt {
  Alignment toAlignment() {
    final Alignment alignment;

    switch (this) {
      case AlignIt.center:
        alignment = Alignment.center;
        break;
      case AlignIt.center_left:
        alignment = Alignment.centerLeft;
        break;
      case AlignIt.top_center:
        alignment = Alignment.topCenter;
        break;
      case AlignIt.center_right:
        alignment = Alignment.centerRight;
        break;
      case AlignIt.bottom_center:
        alignment = Alignment.bottomCenter;
        break;
    }
    return alignment;
  }
}

extension Utility on BuildContext {
  ///next editable field.
  ///
  ///the solution here is to keep calling 'nextFocus()' until 'EditableText' is found
  ///https://stackoverflow.com/questions/52150677/how-to-shift-focus-to-the-next-textfield-in-flutter#:~:text=Just%20use%3A,cursor%20to%20the%20next%20field.
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}

extension ImageExtension on num {
  int renderSize(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final dimensionLength = (this * devicePixelRatio).round();
    // print('ImageExtension: renderSize: devicePixelRatio: $devicePixelRatio, dimensionLength: $dimensionLength');
    return dimensionLength;
  }
}
