import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Flutter code sample for [FocusNode].

void main() async {
  runApp(const FocusNodeExampleApp());
}

class FocusNodeExampleApp extends StatelessWidget {
  const FocusNodeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FocusNode Sample')),
        body: const FocusNodeExample(),
      ),
    );
  }
}

class ColorfulButton extends StatefulWidget {
  const ColorfulButton({super.key});

  @override
  State<ColorfulButton> createState() => _ColorfulButtonState();
}

class _ColorfulButtonState extends State<ColorfulButton> {
  late FocusNode _node;
  bool _focused = false;
  late FocusAttachment _nodeAttachment;
  Color _color = Colors.white;

  @override
  void initState() {
    super.initState();
    _node = FocusNode(debugLabel: 'Button');
    _node.addListener(_handleFocusChange);
    _nodeAttachment = _node.attach(context, onKeyEvent: _handleKeyPress);
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

  KeyEventResult _handleKeyPress(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      print('Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.keyR) {
        print('Changing color to red.');
        setState(() {
          _color = Colors.red;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyG) {
        print('Changing color to green.');
        setState(() {
          _color = Colors.green;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
        print('Changing color to blue.');
        setState(() {
          _color = Colors.blue;
        });
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _node.removeListener(_handleFocusChange);
    // The attachment will automatically be detached in dispose().
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    return GestureDetector(
      onTap: () {
        if (_focused) {
          _node.unfocus();
          hideKeyboardSimpler();
          // hideKeyboard();
        } else {
          _node.requestFocus();
          showKeyboardSimpler();
          // showKeyboard();
        }
      },
      child: Center(
        child: Container(
          width: 400,
          height: 100,
          color: _focused ? _color : Colors.white,
          alignment: Alignment.center,
          child: Text(_focused ? "I'm in color! Press R,G,B!" : 'Press to focus'),
        ),
      ),
    );
  }
}

class FocusNodeExample extends StatelessWidget {
  const FocusNodeExample({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.headlineMedium!,
      child: const ColorfulButton(),
    );
  }
}

Future<void> showKeyboard()  {
  WidgetsFlutterBinding.ensureInitialized();
  return SystemChannels.textInput.invokeMethod('TextInput.show');
}

Future<void> hideKeyboard() {
  WidgetsFlutterBinding.ensureInitialized();
  return SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void showKeyboardSimpler() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await SystemChannels.textInput.invokeMethod('TextInput.show');
}

void hideKeyboardSimpler() async{
  WidgetsFlutterBinding.ensureInitialized();
  return await SystemChannels.textInput.invokeMethod('TextInput.hide');
}
