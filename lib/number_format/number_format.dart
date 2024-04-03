import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:intl/intl.dart';

///https://www.flutterclutter.dev/flutter/tutorials/how-to-create-a-number-input/2021/86522/
void main() {
  inits();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.purple,
      ),
      home: FormatTheNumber(),
    );
  }
}

class FormatTheNumber extends StatelessWidget with GetItMixin {
  FormatTheNumber({super.key, this.initialValue});

  // FormatTheNumber({super.key, this.initialValue}){
  //   var vop = get<ValueOrPrice>().value;
  //   editorController = TextEditingController(text: vop);
  // }
  final String? initialValue;

  late final editorController =
      TextEditingController(text: get<ValueOrPrice>().value);

  @override
  Widget build(BuildContext context) {
    var usFormat = NumberFormat('#,###.00', 'en_US');
    var frFormat =
        NumberFormat.currency(locale: 'fr_FR', symbol: '€', decimalDigits: 2);
    var data = usFormat.format(1234);
    var data1 = frFormat.format(1234);

    var valueOrPrice = watch<ValueOrPrice, String>();

    return Scaffold(
      appBar: AppBar(
        title: Text('NumberFormat'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('data: $data'),
            Text('data1: $data1'),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('price'),
                fillColor: Colors.black45,
                filled: true,
                constraints: BoxConstraints(maxWidth: 300),
                icon: Icon(Icons.euro_symbol_sharp),
                iconColor: Colors.orange,
              ),
              controller: editorController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^([€$]\s?){0,1}\d+\.?\d{0,2}(\s?[€$]){0,1}'),
                ),
                TextInputFormatterExtended(),
              ],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (value) {
                var sanitazedString = value.substring(0, value.length - 1);
                var doubleValue = double.parse(sanitazedString);
                // var currencyString = frFormat.format(doubleValue);
                // get<ValueOrPrice>().value = currencyString;
                print('''onChange: value: $value, 
                    sanitazedString: $sanitazedString,
                    doubleValue: $doubleValue,
                    valueOrPrice: ${get<ValueOrPrice>().value}, 
                    currentLocacle: ${Intl.getCurrentLocale()}''');
              },
            ),
            TextButton(
              onPressed: () {
                var vOrP = get<ValueOrPrice>();
                vOrP.value = '00000';
                print('valueOrPrice: $valueOrPrice, vOrP.value: ${vOrP.value}');
              },
              child: Text('new price'),
            )
          ],
        ),
      ),
    );
  }
}

final goGet = GetIt.I;

ValueOrPrice get valueOrPrice => goGet.get<ValueOrPrice>();

void inits() {
  goGet.registerSingleton<ValueOrPrice>(ValueOrPrice('0.00 €'));
}

class ValueOrPrice extends ValueNotifier<String> {
  ValueOrPrice(super.value);
}

class TextInputFormatterExtended extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}