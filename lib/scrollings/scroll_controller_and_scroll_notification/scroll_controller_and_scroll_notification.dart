import 'package:flutter/material.dart';
import 'package:sbox1/scrollings/scroll_controller_and_scroll_notification/scroll_limit_reached.dart';
import 'package:sbox1/scrollings/scroll_controller_and_scroll_notification/scroll_movement.dart';
import 'package:sbox1/scrollings/scroll_controller_and_scroll_notification/scroll_status.dart';
import 'package:sbox1/scrollings/scroll_controller_and_scroll_notification/scroll_sync/scroll_sync.dart';

/// https://medium.com/@diegoveloper/flutter-lets-know-the-scrollcontroller-and-scrollnotification-652b2685a4ac
/// https://github.com/diegoveloper/flutter-samples/blob/master/lib/scroll_controller/scroll_sync/scroll_sync.dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
      home: MainScrollController(),
    );
  }
}

class MainScrollController extends StatelessWidget {
  onButtonTap(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ScrollController / ScrollNotifiation"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Scroll Limit Reached",
              actionTap: () {
                onButtonTap(ScrollLimitReached(), context);
              },
            ),
            MyMenuButton(
              title: "Scroll Movement",
              actionTap: () {
                onButtonTap(ScrollMovement(), context);
              },
            ),
            MyMenuButton(
              title: "Scroll Status",
              actionTap: () {
                onButtonTap(ScrollStatus(), context);
              },
            ),
            MyMenuButton(
              title: "Scroll Sync",
              actionTap: () {
                onButtonTap(ScrollSync(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String? title;
  final VoidCallback? actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text(title!),
        onPressed: actionTap,
      ),
    );
  }
}