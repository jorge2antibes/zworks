import 'package:flutter/material.dart';

void main () {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.dark(), primarySwatch: Colors.blue,),
      home: ItemList(),
    );
  }
}


/// ValueNotifier can also be used to update the UI when the state
/// changes. In this example, we want to display a list of items
/// and allow the user to delete items by swiping them.
/// https://medium.com/@thekavak/flutter-valuenotifier-with-examples-66b3933d7036
class Item {
  final ValueNotifier<String> name;

  Item(String name) : name = ValueNotifier<String>(name);
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  final List<Item> items = [
    Item('Item 1'),
    Item('Item 2'),
    Item('Item 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final Item item = items[index];

            return Dismissible(
              key: Key(item.name.value),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              child: ListTile(
                title: ValueListenableBuilder<String>(
                  valueListenable: item.name,
                  builder: (BuildContext context, String value, child) {
                    return Text(value);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}