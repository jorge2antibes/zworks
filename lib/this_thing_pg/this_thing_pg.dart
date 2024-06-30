import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import 'animated_svg_icon_wgt.dart';
import 'description_info_wgt.dart';
import 'this_thing_cmds_wgt.dart';
import 'this_thing_imgs_vw.dart';

void main() {
  initGetIt();
  runApp(MyApp());
}

final goGet = GetIt.I;

void initGetIt() {
  goGet.registerSingleton<ScaleState>(ScaleState(false));
}

class ScaleState extends ValueNotifier<bool> {
  ScaleState(super.scaleUp);

  bool get scaleIn => value = true;
  bool get scaleOut => value = false;
  bool get shouldScaleIn => value;
  bool get shouldScaleOut => !value;

  void set scaleIn(bool newVal) => value = newVal;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Colors.purple),
      home: Scaffold(
        body: ThisThingPg(),
      ),
    );
  }
}

class ThisThingPg extends StatelessWidget with GetItMixin {
  ThisThingPg({super.key});

  @override
  Widget build(BuildContext context) {
    // debugInvertOversizedImages = true;

    // watch<ScaleUpState, bool>();

    final thingImages = <String>{
      'assets/photos/0.jpg',
      'assets/photos/1.jpg',
      'assets/photos/2.jpg',
    };
    final screenSize = MediaQuery.of(context).size;

    final foregndImgWidth = screenSize.width * .80;
    final foregndImgHeight = screenSize.height * .75;
    final cmdsAvailableSpace = screenSize.width - foregndImgWidth;
    final theWidgetWidth = cmdsAvailableSpace * .60; // => 35.0;
    final scalePercentage = watch<ScaleState, bool>() ? .45 : .25;
    final ancoredToBottomImg = screenSize.height * scalePercentage;
    final foregndImgWidthComplement = screenSize.width * .20;

    // print('ThisThingPg: build(): thing: $thing');
    print('''ThisThingPg: build(): 
    screenSizeL: $screenSize,
    foregndImgWidth: $foregndImgWidth,
    foregndImgHeight: $foregndImgHeight,
    cmdsAvailableSpace: $cmdsAvailableSpace,
    theWidgetWidth: $theWidgetWidth,
    ''');

    final cmds = <Widget>[
      Center(
        child: AnimatedSvgIconWgt(
          size: theWidgetWidth,
          duration: const Duration(milliseconds: 250),
          pictures: <List<Widget>>[
            [SvgPicture.asset('assets/svgs/transaction_ends.svg')],
            [SvgPicture.asset('assets/svgs/transaction_starts_dollar.svg')],
            // [SvgPicture.asset('assets/svgs/transaction_starts_euro.svg')],
          ],
        ),
      ),
      Center(
        child: AnimatedSvgIconWgt(
          size: theWidgetWidth,
          duration: const Duration(milliseconds: 250),
          pictures: <List<Widget>>[
            [SvgPicture.asset('assets/svgs/envelope_closed.svg')],
            [SvgPicture.asset('assets/svgs/envelope_w_mail.svg')],
          ],
        ),
      ),
      Center(
        child: AnimatedSvgIconWgt(
          size: theWidgetWidth,
          duration: const Duration(milliseconds: 250),
          pictures: [
            [SvgPicture.asset('assets/svgs/messages.svg')],
            [SvgPicture.asset('assets/svgs/new_message.svg')],
          ],
        ),
      ),
      Center(
        child: AnimatedSvgIconWgt(
          size: theWidgetWidth,
          duration: const Duration(milliseconds: 250),
          pictures: [
            [
              SvgPicture.asset('assets/svgs/views_bkg.svg'),
              Center(child: Text('900M', style: GoogleFonts.lato(fontWeight: FontWeight.w300, fontSize: 11))),
            ],
            [SvgPicture.asset('assets/svgs/views.svg')],
          ],
        ),
      ),
      Center(
        child: AnimatedSvgIconWgt(
          size: theWidgetWidth,
          duration: const Duration(milliseconds: 250),
          pictures: [
            [
              SvgPicture.asset('assets/svgs/value_container.svg'),
              const Column(
                children: [
                  Text('70K', style: TextStyle(fontSize: 11)),
                  Text('€', style: TextStyle(fontSize: 11)),
                ],
              ),
            ],
            [
              SvgPicture.asset('assets/svgs/value_outlined.svg'),
            ],
          ],
        ),
      ),
      Center(
        child: Container(
          width: theWidgetWidth,
          height: theWidgetWidth,
          child: SvgPicture.asset(
            'assets/svgs/edit.svg',
          ),
        ),
      ),
    ];

    const double verticalElasticityFactor = 1.2;
    final cmdsheightLenght = cmds.length * theWidgetWidth * verticalElasticityFactor;

    return Scaffold(
      body: Stack(
        children: [
          ThisThingImgsVw(
            images: thingImages,
            imgWidth: foregndImgWidth,
            imgHeight: foregndImgHeight,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 270),
            bottom: 16,
            height: ancoredToBottomImg - 16,
            left: 16,
            right: foregndImgWidthComplement,
            child: DescriptionInfoWgt(),
          ),
          Positioned(
            height: cmdsheightLenght,
            width: cmdsAvailableSpace,
            right: 0,
            bottom: ancoredToBottomImg,
            child: ThisThingCmdsWgt(
              widgetWidth: theWidgetWidth,
              listOfCmds: cmds,
            ),
          ),
        ],
      ),
    );
  }
}
