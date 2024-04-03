void main() {
  test1();

  var exp = RegExp(r'(\w+)');
  String str = 'Parse my string Parse';
  var match = exp.firstMatch(str);
  print('match![0]: ${match![0]}');

  testRegExpMatch();

  testMoney();
}

void test1() {
  var text = 'Dash is a bird';
  var regExp = RegExp(r'(humming)?bird');
  var match = regExp.stringMatch(text);
  print('match: $match');
}

void testRegExpMatch() {
  const pattern =
      r'^\[(?<Time>\s*((?<hour>\d+)):((?<minute>\d+))\.((?<second>\d+)))\]'
      r'\s(?<Message>\s*(.*)$)';

  final regExp = RegExp(
    pattern,
    multiLine: true,
  );

  const multilineText = '[00:13.37] This is a first message.\n'
      '[01:15.57] This is a second message.\n';

  RegExpMatch regExpMatch = regExp.firstMatch(multilineText)!;
  print(regExpMatch.groupNames.join('-')); // hour-minute-second-Time-Message.
  final time = regExpMatch.namedGroup('Time'); // 00:13.37
  final hour = regExpMatch.namedGroup('hour'); // 00
  final minute = regExpMatch.namedGroup('minute'); // 13
  final second = regExpMatch.namedGroup('second'); // 37
  final message =
      regExpMatch.namedGroup('Message'); // This is the first message.
  // final date = regExpMatch.namedGroup('Date'); // Undefined `Date`, throws.

  Iterable<RegExpMatch> matches = regExp.allMatches(multilineText);
  for (final m in matches) {
    print(m.namedGroup('Time'));
    print(m.namedGroup('Message'));
    // 00:13.37
    // This is the first message.
    // 01:15.57
    // This is the second message.
  }
}

void testMoney() {
  var text = '\$0.00';
  var regExp = RegExp(
      r'^\$?((\d{1,3})(?:,[0-9]{3}){0,1}|(\d{1})(?:,[0-9]{3}){0,2}|(\d{1,7}))(\.\d{1,2})?$');
  var match = regExp.stringMatch(text);
  print('match: ${match}');
}
