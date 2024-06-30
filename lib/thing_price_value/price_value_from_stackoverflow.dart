import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _subscriptionFormKey = GlobalKey<FormState>();
  final _subscriptionPriceController = TextEditingController();
  final NumberFormat numFormat = NumberFormat('###,##0.00', 'en_US');
  final NumberFormat numSanitizedFormat = NumberFormat('en_US');
  var currency = 'USD';
  var defaultPrice = '0.00';

  void _validate() {
    if (_subscriptionFormKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _subscriptionFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (cost) {
              if (cost == null || cost.isEmpty) {
                return 'Empty';
              }
              return null;
            },
            textInputAction: TextInputAction.next,

            /// Set TextFormField default value
            controller: _subscriptionPriceController..text = defaultPrice,
            decoration: InputDecoration(
              hintText: 'Price',
              prefixText:
              NumberFormat.simpleCurrency(name: currency).currencySymbol,
            ),
            onTap: () {
              var textFieldNum = _subscriptionPriceController.value.text;
              var numSanitized = numSanitizedFormat.parse(textFieldNum);
              _subscriptionPriceController.value = TextEditingValue(
                /// Clear if TextFormField value is 0
                text: numSanitized == 0 ? '' : '$numSanitized',
                selection:
                TextSelection.collapsed(offset: '$numSanitized'.length),
              );
            },
            //https://stackoverflow.com/questions/68740586/flutter-textformfield-display-value-with-numberformat
            // onChanged: (price) {
            //   /// TODO Display [formattedPrice] in TextFormField
            //   var formattedPrice = numFormat.format(double.parse(price));
            //   print('Formatted $formattedPrice');
            //   var numSanitized = numSanitizedFormat.parse(price);
            //   print('Sanitized: $numSanitized');
            //   _subscriptionPriceController.value = TextEditingValue(
            //     text: price,
            //     selection: TextSelection.collapsed(offset: price.length),
            //   );
            // },
            //https://stackoverflow.com/questions/68740586/flutter-textformfield-display-value-with-numberformat
            onFieldSubmitted: (price) {
              /// Set value to 0 if TextFormField value is empty
              if (price == '') price = '0';
              final formattedPrice = numFormat.format(double.parse(price));
              print('Formatted $formattedPrice');
              _subscriptionPriceController.value = TextEditingValue(
                text: formattedPrice,
                selection:
                TextSelection.collapsed(offset: formattedPrice.length),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _validate,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}