import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

/// Flutter code sample for [Form] with focus node.

///https://stackoverflow.com/questions/49341856/how-to-detect-when-a-textfield-is-selected-in-flutter
///https://docs.flutter.dev/cookbook/forms/focus
void main() {
  runApp(const FormExampleApp());
}

class FormExampleApp extends StatelessWidget {
  const FormExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Form with FocusNode')),
        body: FormWithFocusNode(),
      ),
    );
  }
}

class FormWithFocusNode extends StatefulWidget with GetItStatefulWidgetMixin {
  FormWithFocusNode({super.key});

  @override
  State<FormWithFocusNode> createState() => _FormWithFocusNodeState();
}

class _FormWithFocusNodeState extends State<FormWithFocusNode> with GetItStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final FocusNode _focusNode1;
  late final FocusNode _focusNode2;
  late final TextEditingController _controller1;
  late final TextEditingController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  void _onEditingCompleteAction() {
    print('_FormWithFocusNodeState: onEditingCompleteAction()');
  }

  void _onSaveAction(String? newValue) {
    print('_FormWithFocusNodeState: onSaveAction(): newValue: $newValue');
  }


  void _clear1() {
    print('_FormWithFocusNodeState: clear1():');
    _controller1.clear();
  }


  void _clear2() {
    print('_FormWithFocusNodeState: clear2():');
    _controller2.clear();
  }

  @override
  Widget build(BuildContext context) {
    // I have used target because the object is not in getit
    final hasFocusOn1 = watchOnly<FocusNode, bool>((focusNode) => focusNode.hasPrimaryFocus, target: _focusNode1);
    if (hasFocusOn1) {
      print('_FormWithFocusNodeState: build(): gained hasFocusOn1: $hasFocusOn1');
      _clear1();
    } else {
      print('_FormWithFocusNodeState: build(): lost hasFocusOn1: $hasFocusOn1');
    }
    // I have used target because the object is not in getit
    final hasFocusOn2 = watchOnly<FocusNode, bool>((focusNode) => focusNode.hasPrimaryFocus, target: _focusNode2);
    if (hasFocusOn2) {
      print('_FormWithFocusNodeState: build(): gained focus: hasFocusOn2: $hasFocusOn2');
      _clear2();
    } else {
      print('_FormWithFocusNodeState: build(): lost focus: hasFocusOn2: $hasFocusOn2');
    }
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _controller1,
            onEditingComplete: () {
              print('_FormWithFocusNodeState: build(): TextFormField: onEditingComplete()');
              _onEditingCompleteAction();
            },
            onSaved: (newValue) {
              print('_FormWithFocusNodeState: build(): TextFormField: onSave()');
              _onSaveAction(newValue);
            },
            focusNode: _focusNode1,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controller2,
            focusNode: _focusNode2,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
