import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.purple),
      home: TheTest(),
    );
  }
}

class TheTest extends StatefulWidget {
  const TheTest({super.key});

  @override
  State<TheTest> createState() => _TheTestState();
}

class _TheTestState extends State<TheTest> {
  double viewportHeight = 200;
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('supperposition with scrollMetricsNotification'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          viewportHeight += 10.0;
        }),
      ),
      body: NotificationListener<ScrollMetricsNotification>(
        onNotification: (notification) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Scroll metrics changed')));
          return true;
        },
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SizedBox(
            height: viewportHeight,
            width: double.infinity,
            child: const SingleChildScrollView(
              // primary: true,
              // controller: scrollController,
              child: FlutterLogo(
                size: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
