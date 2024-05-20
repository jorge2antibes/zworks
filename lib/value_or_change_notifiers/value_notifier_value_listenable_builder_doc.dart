import 'package:flutter/material.dart';

/// Flutter code sample for [ValueListenableBuilder].
/// If your builder function contains a subtree that does not depend on the
/// value of the ValueListenable, it's more efficient to build that subtree
/// once instead of rebuilding it on every animation tick.
/// If you pass the pre-built subtree as the child parameter, the ValueListenableBuilder
/// will pass it back to your builder function so that you can incorporate it
/// into your build.
/// Using this pre-built child is entirely optional, but can improve performance
/// significantly in some cases and is therefore a good practice.
/// https://api.flutter.dev/flutter/widgets/ValueListenableBuilder-class.html
void main() => runApp(const ValueListenableBuilderExampleApp());

class ValueListenableBuilderExampleApp extends StatelessWidget {
  const ValueListenableBuilderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ValueListenableBuilderExample(),
    );
  }
}

class ValueListenableBuilderExample extends StatefulWidget {
  const ValueListenableBuilderExample({super.key});

  @override
  State<ValueListenableBuilderExample> createState() =>
      _ValueListenableBuilderExampleState();
}

class _ValueListenableBuilderExampleState
    extends State<ValueListenableBuilderExample> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableBuilder Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            ValueListenableBuilder<int>(
              builder: (BuildContext context, int value, Widget? child) {
                // This builder will only get called when the _counter
                // is updated.
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CountDisplay(count: value),
                    child!,
                  ],
                );
              },
              valueListenable: _counter,
              // The child parameter is most helpful if the child is
              // expensive to build and does not depend on the value from
              // the notifier.
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: FlutterLogo(size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () => _counter.value += 1,
      ),
    );
  }
}

class CountDisplay extends StatelessWidget {
  const CountDisplay({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsetsDirectional.all(10),
      child: Text('$count', style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
