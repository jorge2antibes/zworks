// Markdown
// You are allowed to use most markdown formatting in your doc comments and dart doc will process it accordingly using the markdown package.
//
// There are tons of guides out there already to introduce you to Markdown. Its universal popularity is why we chose it. Here’s just a quick example to give you a flavor of what’s supported:
//
// This is a paragraph of regular text.
//
// This sentence has *two* _emphasized_ words (italics) and **two**
// __strong__ ones (bold).
//
// A blank line creates a separate paragraph. It has some `inline code`
// delimited using backticks.
//
// * Unordered lists.
// * Look like ASCII bullet lists.
// * You can also use `-` or `+`.
//
// 1. Numbered lists.
// 2. Are, well, numbered.
// 1. But the values don't matter.
//
//     * You can nest lists too.
//     * They must be indented at least 4 spaces.
//     * (Well, 5 including the space after `///`.)
//
// Code blocks are fenced in triple backticks:
//
// ```dart
// this.code
//     .will
//     .retain(its, formatting);
// ```
//
// The code language (for syntax highlighting) defaults to Dart. You can
// specify it by putting the name of the language after the opening backticks:
//
// ```html
// <h1>HTML is magical!</h1>
// ```
//
// Links can be:
//
// * https://www.just-a-bare-url.com
// * [with the URL inline](https://google.com)
// * [or separated out][ref link]
//
// [ref link]: https://google.com
//
// # A Header
//
// ## A subheader
//
// ### A subsubheader
//
// #### If you need this many levels of headers, you're doing it wrong


import 'dart:ui';

class Images {
  // static const String young_00 = 'assets/images/young_00.png';
  // static const String young_01 = 'assets/images/young_01.png';
  // static const String young_02 = 'assets/images/young_02.png';
  // static const String young_03 = 'assets/images/young_03.png';
  // static const String old_00 = 'assets/images/old_00.png';
  // static const String old_01 = 'assets/images/old_01.png';
  // static const String old_02 = 'assets/images/old_02.png';
  // static const String old_03 = 'assets/images/old_03.png';
  // static const String beauty_00 = 'assets/images/beauty_00.png';
  // static const String beauty_01 = 'assets/images/beauty_01.png';
  static const String beauty_02 = 'assets/images/beauty_02.png';
  // static const String beauty_03 = 'assets/images/beauty_03.png';
  // static const String handsome_00 = 'assets/images/handsome_00.png';
  // static const String handsome_01 = 'assets/images/handsome_01.png';
  // static const String handsome_02 = 'assets/images/handsome_02.png';
  static const String handsome_03 = 'assets/images/handsome_03.png';
}

class Videos {
  static const String eu_flag_00 = 'assets/videos/eu_flag_00.mp4';
  static const String eu_flag_01 = 'assets/videos/eu_flag_01.mp4';
  static const String eu_flag_02 = 'assets/videos/eu_flag_02.mp4';
  static const String eu_flag_03 = 'assets/videos/eu_flag_03.gif';
}

class Audios {
  static const String eu_00 = 'assets/audios/eu_00.mp3';
  static const String eu_01 = 'assets/audios/eu_01.mp3';
}

class BkgPics {
  static const item_01 = 'assets/images/bkgs/01.png';
  static const item_02 = 'assets/images/bkgs/02.png';
  static const item_03 = 'assets/images/bkgs/03.png';
  static const item_04 = 'assets/images/bkgs/04.png';
  static const item_05 = 'assets/images/bkgs/05.png';
  static const item_06 = 'assets/images/bkgs/06.png';
  static const item_07 = 'assets/images/bkgs/07.png';
  static const item_08 = 'assets/images/bkgs/08.png';
  static const item_09 = 'assets/images/bkgs/09.png';
  static const item_10 = 'assets/images/bkgs/10.png';
  static const item_11 = 'assets/images/bkgs/11.png';
  static const item_12 = 'assets/images/bkgs/12.png';
}

class SignIns {
  static const woman_on_man = 'assets/images/sign_ins/00.png';
  static const man_on_woman = 'assets/images/sign_ins/01.png';
}

final bkgPics = <String>{
  BkgPics.item_01,
  BkgPics.item_02,
  BkgPics.item_03,
  BkgPics.item_04,
  BkgPics.item_05,
  BkgPics.item_06,
  BkgPics.item_07,
  BkgPics.item_08,
  BkgPics.item_09,
  BkgPics.item_10,
  BkgPics.item_11,
  BkgPics.item_12,
};

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
const keywords_matcher = r'^([a-zA-Z]{1,13}|[a-zA-Z]{1,13}\s|[a-zA-Z]{1,13}\s[a-zA-Z]{1,13}|[a-zA-Z]{1,13}\s[a-zA-Z]{1,13}\s)$';

const Color fields_color = Color(0xAA000000);
