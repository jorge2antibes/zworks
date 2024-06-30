import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sbox1/svg/animated_svg/animated_svg_icon_showcase.dart';

///this sandbox sets up the value/price icon animation and value/price integration into
///the animation. I have finally set the price and the currency programmatically by
///supporting both Text widgets with a Column widget.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('animated svg'),
        ),
        body: Center(
          child: AnimatedSvgTxtIconShowcase(
            svgSize: 62,
            pictures: <List<Widget>>[
              [
                SvgPicture.asset('assets/svgs_at_things/value_container.svg'),
                const Column(
                  children: [
                    Text('70', style: TextStyle(color: Colors.white)),
                    Text('€', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
              [
                SvgPicture.asset('assets/svgs_at_things/views.svg'),
                const Text('80M', style: TextStyle(color: Colors.white)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

///This was done with the currency sign crafted at the icon itself which is not
///suitable for localizations. I will try to add a column to put the currency sign
///into it.
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Visibility vs OffStage'),
//         ),
//         body: Center(
//           child: AnimatedSvgTxtIconShowcase(
//             svgSize: 62,
//             pictures: <List<Widget>>[
//               [
//                 SvgPicture.asset('assets/svgs_at_things/value_container.svg'),
//                 Text('70K', style: TextStyle(color: Colors.white),),
//               ],
//               [
//                 SvgPicture.asset('assets/svgs_at_things/views.svg'),
//                 Text('80M', style: TextStyle(color: Colors.white),),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
