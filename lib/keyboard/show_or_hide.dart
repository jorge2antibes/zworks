import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'show hide keyboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 300,
          child: TextButton(
            onPressed: () {
              if (hidden) {
                showKeyboard();
              } else {
                hideKeyboard();
              }
              setState(() {
                hidden = !hidden;
              });
            },
            child: hidden ? const Text('show keyboard') : const Text('hide keyboard'),
          ),
        ),
      ),
    );
  }
}

Future<void> showKeyboard() {
  WidgetsFlutterBinding.ensureInitialized();
  return SystemChannels.textInput.invokeMethod('TextInput.show');
}

Future<void> hideKeyboard() {
  WidgetsFlutterBinding.ensureInitialized();
  return SystemChannels.textInput.invokeMethod('TextInput.hide');
}
