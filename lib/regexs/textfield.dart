import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///https://www.flutterclutter.dev/flutter/tutorials/how-to-create-a-number-input/2021/86522/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'create number input',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: NumberInput(
              label: 'lablejdc',
              value: '0.00 \$',
              allowDecimal: true,
            ),
          ),
        ),
      ),
    );
  }
}

class NumberInput extends StatelessWidget {
  NumberInput({
    required this.label,
    this.controller,
    this.value,
    this.onChanged,
    this.error,
    this.icon,
    this.allowDecimal = false,
  });

  final TextEditingController? controller;
  final String? value;
  final String label;
  final Function? onChanged;
  final String? error;
  final Widget? icon;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: value,
      onChanged: onChanged as void Function(String)?,
      readOnly: false,
      keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
      inputFormatters: <TextInputFormatter>[
        TextInputFormatter.withFunction(
          (oldValue, newValue) {
            print('''oldValue: $oldValue, newValue: $newValue''');
            var partial = newValue.text
                .replaceAll(r'^[€$]', '')
                .trim()
                .replaceAll('00.', '0.')
                .replaceAll(r'[\.]{2,}', '.')
                .replaceFirstMapped(
              r'^0{1,}',
              (match) {
                print('match.input: ${match.input}');
                var m = match.input;
                return '';
              },
            );
            print('withFunction(): ${partial}');

            return newValue.copyWith(text: partial);
          },
        ),
        // FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
        // TextInputFormatterExtended()
      ],
      decoration: InputDecoration(
        label: Text(label),
        errorText: error,
        icon: icon,
      ),
    );
  }

  String _getRegexString() =>
      allowDecimal ? r'^([€$]\s?){0,1}\d+\.?\d{0,2}(\s?[€$]){0,1}' : r'[0-9]';
// allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';
}

class TextInputFormatterExtended extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    final stringBuffer = StringBuffer();
    var startIndex = newValue.selection.start;
    var endIndex = newValue.selection.end;

    print('''oldValue: $oldValue, 
    newValue: $newValue,
    newTextLength: $newTextLength,
    startindex: $startIndex,
    endIndex: $endIndex''');

    stringBuffer.write(newValue.text);

    return TextEditingValue(
      text: stringBuffer.toString(),
      selection: TextSelection.collapsed(offset: startIndex),
      // selection: TextSelection.collapsed(offset: endIndex),
    );
  }
}

String trimCurrencies(String str) {
  str = str.replaceAll(r'^[€$]', '');
  return str.trim();
}
