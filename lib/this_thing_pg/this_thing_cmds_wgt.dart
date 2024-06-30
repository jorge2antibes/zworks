
import 'package:flutter/material.dart';

class ThisThingCmdsWgt extends StatelessWidget {
  const ThisThingCmdsWgt({
    super.key,
    required this.listOfCmds,
    required this.widgetWidth,
  });

  final List<Widget> listOfCmds;
  final double widgetWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          print('''ThisThingCmdsWgt: build(): 
          constraints: 
              hasInfiniteHeight: ${constraints.hasInfiniteHeight},
              hasTightHeight: ${constraints.hasTightHeight}, 
              hasBoundedHeight : ${constraints.hasBoundedHeight},
              biggest: ${constraints.biggest},
              maxWidth: ${constraints.maxWidth},
              maxHeight: ${constraints.maxHeight}
              smallest: ${constraints.smallest},
              minWidth: ${constraints.minWidth},
              minHeight: ${constraints.minHeight},
              ''');
          return Container(
            color: Colors.black38,
            width: widgetWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listOfCmds,
              ),
            ),
          );
        },
      ),
    );
  }
}
