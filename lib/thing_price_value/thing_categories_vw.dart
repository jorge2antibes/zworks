// import 'package:things/commons/constants.dart';
// import 'package:things/main.dart';
// import 'package:things/uis/widgets/keyboard_wgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'keyboard_wgt.dart';
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
  var initialValue = '0.00';
  final textController = TextEditingController();

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
          child: Column(
            children: [
              CurrencyEx(
                subscriptionPriceController: _subscriptionPriceController,
                defaultPrice: defaultPrice,
                currency: currency,
                numSanitizedFormat: numSanitizedFormat,
                numFormat: numFormat,
              ),
              ThingCategoriesVw(formKey: _subscriptionFormKey),
              TextFormField(
              
                initialValue: initialValue,
                // controller: textController,
                inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  prefixText: NumberFormat.simpleCurrency(locale: 'fr_FR').currencySymbol,
                ),
                onChanged: (value) {
                  print('onChange: value: $value, initialValue: $initialValue');
                  var formattedValue = numFormat.format(double.parse(value));
                  setState(() {
                    initialValue = formattedValue;
                    print('onChange:(AFTER) value: $value, initialValue: $initialValue');

                  });
                },
              ),
            ],
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

class CurrencyEx extends StatelessWidget {
  const CurrencyEx({
    super.key,
    required TextEditingController subscriptionPriceController,
    required this.defaultPrice,
    required this.currency,
    required this.numSanitizedFormat,
    required this.numFormat,
  }) : _subscriptionPriceController = subscriptionPriceController;

  final TextEditingController _subscriptionPriceController;
  final String defaultPrice;
  final String currency;
  final NumberFormat numSanitizedFormat;
  final NumberFormat numFormat;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintText: 'thing value',
        prefixText: NumberFormat.simpleCurrency(name: currency).currencySymbol,
      ),
      onTap: () {
        var textFieldNum = _subscriptionPriceController.value.text;
        var numSanitized = numSanitizedFormat.parse(textFieldNum);
        _subscriptionPriceController.value = TextEditingValue(
          /// Clear if TextFormField value is 0
          text: numSanitized == 0 ? '' : '$numSanitized',
          selection: TextSelection.collapsed(offset: '$numSanitized'.length),
        );
      },
      //https://stackoverflow.com/questions/68740586/flutter-textformfield-display-value-with-numberformat
      // onChanged: (price) {
      //   /// TODO Display [formattedPrice] in TextFormField
      //   var formattedPrice = numFormat.format(double.parse(price));
      //   debugPrint('Formatted $formattedPrice');
      //   var numSanitized = numSanitizedFormat.parse(price);
      //   debugPrint('Sanitized: $numSanitized');
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
        debugPrint('Formatted $formattedPrice');
        _subscriptionPriceController.value = TextEditingValue(
          text: formattedPrice,
          selection: TextSelection.collapsed(offset: formattedPrice.length),
        );
      },
    );
  }
}

class ThingCategoriesVw extends StatefulWidget {
  const ThingCategoriesVw({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<ThingCategoriesVw> createState() => _ThingCategoriesVwState();
}

class _ThingCategoriesVwState extends State<ThingCategoriesVw> {
  late final TextEditingController _controller;
  final maxLength = 26;
  final _fieldKey = GlobalKey<FormFieldState>();
  final NumberFormat numFormat = NumberFormat('###,##0.00', 'en_US');
  final NumberFormat numSanitizedFormat = NumberFormat('en_US');


  String? _validator(String? value) {
    debugPrint('_ThingCategoriesVwState: validator called: value: $value');

    final oneOrTwoStringsSeparatedBySpace = RegExp(keywords_matcher);
    if (value != null) {
      if (oneOrTwoStringsSeparatedBySpace.hasMatch(value)) {
        debugPrint(
            '_ThingCategoriesVwState: validator called: value: $value: Validated');
        return null;
      } else if (value.isEmpty) {
        debugPrint(
            '_ThingCategoriesVwState: validator called: value: $value: Validated');
        return null;
      } else {
        return 'You must enter only alpha chars and space if necessary';
      }
    } else {
      return 'you must enter a category';
    }
  }

  void _updateThingState() {
    debugPrint('_ThingCategoriesVwState: _updateThingState()');

    if (_fieldKey.currentState!.validate()) {
      KeyboardWgt.dismiss(context);
      _controller.text = '';
    }
    debugPrint(
        '_ThingCategoriesVwState: _updateThingState(): thingState: .title: \${thingState.value.title}');
    debugPrint(
        '_ThingCategoriesVwState: _updateThingState(): thingState: .description: \${thingState.value.description}');
    debugPrint(
        '_ThingCategoriesVwState: _updateThingState(): thingState: .categories: \${thingState.value.categories}');
  }

  void _saveThingState(String? value) {
    debugPrint('_ThingCategoriesVwState: _saveThingState()');

    if (value != null && value.isNotEmpty) {
      debugPrint(
          '_ThingCategoriesVwState: _saveThingState(): value is not null and is not empty');
    }
    debugPrint(
        '_ThingCategoriesVwState: _saveThingState(): value is either null or empty');
  }

  void _processor(String value) {
    debugPrint(
        '_ThingCategoriesVwState: _processor(): $value: lenght: ${value.length}');
    _fieldKey.currentState?.validate();
  }

  void makeItVisibleAndClear() {
    // https://stackoverflow.com/questions/73152900/how-to-scroll-dialog-content-to-focused-textfield-in-flutter
    Scrollable.ensureVisible(_fieldKey.currentContext!);
    _clearTextField();
  }

  void _clearTextField() {
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _fieldKey,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      maxLength: maxLength,
      style: TextStyle(fontSize: 21),
      controller: _controller,
      textInputAction: TextInputAction.done,
      validator: (value) => _validator(value),
      onEditingComplete: _updateThingState,
      onSaved: _saveThingState,
      onChanged: _processor,
      onTap: makeItVisibleAndClear,
      decoration: InputDecoration(
        prefixText: NumberFormat.simpleCurrency(locale: 'fr_FR').currencySymbol,
        helperText: 'Either 1 or 2 words separated by space',
        errorStyle: const TextStyle(inherit: true, color: Colors.red),
        errorMaxLines: 2,
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        border: const UnderlineInputBorder(borderSide: BorderSide.none),
        fillColor: fields_color,
        filled: true,
        hintText: 'Keywords ex. cars, new cars...',
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, child) {
            return value.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    color: Colors.white,
                    onPressed: () => _clearTextField(),
                    icon: Icon(Icons.close),
                  );
          },
        ),
      ),
    );
  }
}
