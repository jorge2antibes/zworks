import 'dart:ui';

import 'package:flutter/material.dart';

class SignIns {
  static const woman_on_man = 'assets/images/sign_ins/00.png';
  static const man_on_woman = 'assets/images/sign_ins/01.png';
}

enum AlignIt {
  center(0),
  center_left(1),
  top_center(2),
  center_right(3),
  bottom_center(0),
  ;

  final int rotation;

  const AlignIt(this.rotation);
}

//* RegExps here:
//* to test: https://regexr.com/

/// Matcher for categories (or keywords) to classify a thing
///
/// Starting from the begin of the line _'^'_, creates a capturing group by enclosing in _'()'_ which allows for
/// implementing the __'|'__ operator
///
/// Declares the char set and its range by _'[a-zA-Z]{1,13}'_ that is to match:
///
/// * match one or more chars up to 13
/// * match one or more chars up to 13 _trailed by _'emptyspace'_, __Or__
/// * match one or more chars up to 13 _trailed by _'emptyspace'_ followed by another char set, __Or__
/// * match one or more chars up to 13 _trailed by _'emptyspace'_ followed by another char set trailed by emptyspace, __Otherwise__
/// * it fails
///
const keywords_matcher =
    r'^([a-zA-Z]{1,13}|[a-zA-Z]{1,13}\s|[a-zA-Z]{1,13}\s[a-zA-Z]{1,13}|[a-zA-Z]{1,13}\s[a-zA-Z]{1,13}\s)$';

const Color fields_color = Color(0xAA000000);
