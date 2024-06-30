import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:sbox1/swipe_detector/swipe_detector_lib.dart';
import 'package:sbox1/this_thing_pg/this_thing_pg.dart';

class DescriptionInfoWgt extends StatefulWidget with GetItStatefulWidgetMixin {
  DescriptionInfoWgt({super.key});

  @override
  State<DescriptionInfoWgt> createState() => _DescriptionInfoWgtState();
}

class _DescriptionInfoWgtState extends State<DescriptionInfoWgt> with SingleTickerProviderStateMixin, GetItStateMixin {
  late final AnimationController _animationController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    // _scrollController = ScrollController();
    _scrollController = ScrollController()..addListener(listen);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.removeListener(listen);
    super.dispose();
  }

  void listen() {
    print('''_DescriptionInfoWgtState: listen(): 
            _scrollController.position.pixels: ${_scrollController.position.pixels},
            _scrollController.position.minScrollExtent: ${_scrollController.position.minScrollExtent},
            _scrollController.position.maxScrollExtent: ${_scrollController.position.maxScrollExtent},
            _scrollController.position.outOfRange: ${_scrollController.position.outOfRange},
            _scrollController.position.atEdge: ${_scrollController.position.atEdge},
            _scrollController.position.extentBefore: ${_scrollController.position.extentBefore},
            _scrollController.position.extentInside: ${_scrollController.position.extentInside},
            _scrollController.position.extentAfter: ${_scrollController.position.extentAfter},
            _scrollController.position.extendTotal: ${_scrollController.position.extentTotal},
            _scrollController.offset: ${_scrollController.offset},
            _scrollController.initialScrollOffset: ${_scrollController.initialScrollOffset},
            ''');
  }

  @override
  Widget build(BuildContext context) {
    var shouldScaleIn = watch<ScaleState, bool>();
    final scaleState = goGet<ScaleState>();
    return Column(
      children: [
        Expanded(
          child: Container(
            // margin: const EdgeInsets.only(left: 8, top: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    color: Colors.transparent,
                    width: 50,
                    margin: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: const Text(
                      'Old House in the middle',
                      maxLines: 1,
                      style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(
                      right: 8,
                    ),
                    child: const Text(
                      '€ 880.00',
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              // padding: EdgeInsets.all(8),
              // margin: const EdgeInsets.all(8),
              // color: Colors.black38,
              child: const Text(
                'When I think of those eastern lights, muggy nights '
                'curtains drown in the little room downstairs'
                'prima donna lord you should have been there'
                'sitting like a princes perched in to the electric chair'
                'But there\'s no one here but I don\'t hear you, anymore'
                'when all gone crazy lately, my friends up there rolling down the'
                'basement floor,'
                'Someone safe my live tongiht, sugar bear, '
                'although can you hince to me didn\'t you dear,'
                'you nearly had me wropped and tight otherbout '
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'it\'s a little bit funny, this feelling inside'
                'I\'m not one of those who can easily hide',
                style: TextStyle(
                  fontSize: 16,
                  overflow: TextOverflow.fade,
                ),
                // overflow: TextOverflow.fade,
                // maxLines: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// NotificationListener<UserScrollNotification>(
// onNotification: (notification) {
// if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
// print('''_DescriptionInfoWgtState: initState():
//                     ScrollController: ScrollDirection.forward''');
// // I can eventuall use setState() here
// } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
// print('''_DescriptionInfoWgtState: initState():
//                     ScrollController: ScrollDirection.reverse''');
// // I can eventuall use setState() here
// }
//
// return true;
// },
// child:
