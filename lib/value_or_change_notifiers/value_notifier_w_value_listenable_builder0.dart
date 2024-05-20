import 'package:flutter/material.dart';
/// https://medium.com/@thekavak/flutter-valuenotifier-with-examples-66b3933d7036
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: CounterApp(),
    );
  }
}

class Counter {
  final ValueNotifier<int> count = ValueNotifier<int>(0);

  void incrementCount() {
    count.value++;
  }
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Count:',
            ),
            ValueListenableBuilder<int>(
              valueListenable: counter.count,
              builder: (BuildContext context, int value, child) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter.incrementCount();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
