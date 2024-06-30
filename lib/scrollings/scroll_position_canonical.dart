import 'package:flutter/material.dart';

/// Flutter code sample for [ScrollController] & [ScrollNotification].

void main() => runApp(const ScrollNotificationDemo());

class ScrollNotificationDemo extends StatefulWidget {
  const ScrollNotificationDemo({super.key});

  @override
  State<ScrollNotificationDemo> createState() => _ScrollNotificationDemoState();
}

class _ScrollNotificationDemoState extends State<ScrollNotificationDemo> {
  ScrollNotification? _lastNotification;
  late final ScrollController _controller;
  bool _useController = true;

  // This method handles the notification from the ScrollController.
  void _handleControllerNotification() {
    // print('''Notified through the scroll controller.
    //    // ScrollController: ${_controller},
    //    ScrollController: position.:
    //        position.hasContentDimensions: ${_controller.position.hasContentDimensions},
    //        position.havePositions: ${_controller.position.haveDimensions},
    //        position.hasViewportDimension: ${_controller.position.hasViewportDimension},
    //        position.viewPortDimension: ${_controller.position.viewportDimension},
    //        position.keepScrollOffset: ${_controller.position.keepScrollOffset},
    //        position.hasPixels: ${_controller.position.hasPixels},
    //        position.pixels: ${_controller.position.pixels},
    //        position.minScrollExtend: ${_controller.position.minScrollExtent},
    //        position.maxScrollExtend: ${_controller.position.maxScrollExtent},
    //        position.allowImplicitScrolling: ${_controller.position.allowImplicitScrolling},
    //        position.isScrollingNotifier: ${_controller.position.isScrollingNotifier},
    //        position.outOfRange: ${_controller.position.outOfRange},
    //        position.extendBefore: ${_controller.position.extentBefore},
    //        position.extendInside${_controller.position.extentInside},
    //        position.extendAfter: ${_controller.position.extentAfter},
    //        position.extendTotal${_controller.position.extentTotal},
    //        position.atEdge: ${_controller.position.atEdge},
    //        position.axis: ${_controller.position.axis},
    //        position.axisDirection: ${_controller.position.axisDirection},
    //        position.context${_controller.position.context},
    //        position.physics${_controller.position.physics},
    //        position.userScrollDirection: ${_controller.position.userScrollDirection},
    //     ''');
    print('''Notified through the scroll controller.
        // ScrollController: ${_controller},
        // ScrollController: offset: ${_controller.offset},
        // ScrollController: initialScrollOffset: ${_controller.initialScrollOffset},
        // ScrollController: keppScrollOffset: ${_controller.keepScrollOffset},
        // ScrollController: positions[] ${_controller.positions},
        // ScrollController: position: ${_controller.position},
        ScrollController: position.:
           position.hasContentDimensions: ${_controller.position.hasContentDimensions},
           position.havePositions: ${_controller.position.haveDimensions},
           position.hasViewportDimension: ${_controller.position.hasViewportDimension},
           position.viewPortDimension: ${_controller.position.viewportDimension},
           position.keepScrollOffset: ${_controller.position.keepScrollOffset},
           position.hasPixels: ${_controller.position.hasPixels},
           position.pixels: ${_controller.position.pixels},
           position.minScrollExtend: ${_controller.position.minScrollExtent},
           position.maxScrollExtend: ${_controller.position.maxScrollExtent},
           position.allowImplicitScrolling: ${_controller.position.allowImplicitScrolling},
           position.isScrollingNotifier: ${_controller.position.isScrollingNotifier},
           position.outOfRange: ${_controller.position.outOfRange},
           position.extendBefore: ${_controller.position.extentBefore},
           position.extendInside${_controller.position.extentInside},
           position.extendAfter: ${_controller.position.extentAfter},
           position.extendTotal${_controller.position.extentTotal},
           position.atEdge: ${_controller.position.atEdge},
           position.axis: ${_controller.position.axis},
           position.axisDirection: ${_controller.position.axisDirection},
           position.context${_controller.position.context},
           position.physics${_controller.position.physics},
           position.userScrollDirection: ${_controller.position.userScrollDirection},
        ''');
    // Access the position directly through the controller for details on the
    // scroll position.
  }

  // This method handles the notification from the NotificationListener.
  bool _handleScrollNotification(ScrollNotification notification) {
    print('''Notified through scroll notification.
        notification: ${notification},
          notification.metrics: ${notification.metrics},
          notification.metrics.maxScrollExtent: ${notification.metrics.maxScrollExtent},
          notification.metrics.minScrollExtent: ${notification.metrics.minScrollExtent},
          notification.metrics.axisDirection: ${notification.metrics.axisDirection},
          notification.metrics.axis: ${notification.metrics.axis},
          notification.metrics.atEdge: ${notification.metrics.atEdge},
          notification.metrics.devicePixelRation: ${notification.metrics.devicePixelRatio},
          notification.metrics.extendBefore: ${notification.metrics.extentBefore},
          notification.metrics.extendInside: ${notification.metrics.extentInside},
          notification.metrics.extendAfter: ${notification.metrics.extentAfter},
          notification.metrics.extendTotal: ${notification.metrics.extentTotal},
          notification.metrics.hasContentDimensions: ${notification.metrics.hasContentDimensions},
          notification.metrics.hasPixels: ${notification.metrics.hasPixels},
          notification.metrics.pixels: ${notification.metrics.pixels},
          notification.metrics.hasViewportDimensions: ${notification.metrics.hasViewportDimension},
          notification.metrics.viewportDimension: ${notification.metrics.viewportDimension},
          notification.metrics.outOfRange: ${notification.metrics.outOfRange},
          notification.depth: ${notification.depth},
          ''');
    // The position can still be accessed through the scroll controller, but
    // the notification object provides more details about the activity that is
    // occurring.
    if (_lastNotification.runtimeType != notification.runtimeType) {
      setState(() {
        // Call set state to respond to a change in the scroll notification.
        _lastNotification = notification;
      });
    }

    // Returning false allows the notification to continue bubbling up to
    // ancestor listeners. If we wanted the notification to stop bubbling,
    // return true.
    return false;
  }

  @override
  void initState() {
    _controller = ScrollController();
    if (_useController) {
      // When listening to scrolling via the ScrollController, call
      // `addListener` on the controller.
      _controller.addListener(_handleControllerNotification);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ListView.separated works very similarly to this example with
    // CustomScrollView & SliverList.
    Widget body = CustomScrollView(
      // Provide the scroll controller to the scroll view.
      controller: _controller,
      slivers: <Widget>[
        SliverList.separated(
          itemCount: 50,
          itemBuilder: (_, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: Text('Item $index'),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
        ),
      ],
    );

    if (!_useController) {
      // If we are not using a ScrollController to listen to scrolling,
      // let's use a NotificationListener. Similar, but with a different
      // handler that provides information on what scrolling is occurring.
      body = NotificationListener<UserScrollNotification>(
        // body = NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: body,
      );
    }

    return MaterialApp(
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Listening to a ScrollPosition'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (!_useController) Text('Last notification: ${_lastNotification.runtimeType}'),
                if (!_useController) const SizedBox.square(dimension: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('with:'),
                    Radio<bool>(
                      value: true,
                      groupValue: _useController,
                      onChanged: _handleRadioChange,
                    ),
                    const Text('ScrollController'),
                    Radio<bool>(
                      value: false,
                      groupValue: _useController,
                      onChanged: _handleRadioChange,
                    ),
                    const Text('NotificationListener'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: body,
      ),
    );
  }

  void _handleRadioChange(bool? value) {
    if (value == null) {
      return;
    }
    if (value != _useController) {
      setState(() {
        // Respond to a change in selected radio button, and add/remove the
        // listener to the scroll controller.
        _useController = value;
        if (_useController) {
          _controller.addListener(_handleControllerNotification);
        } else {
          _controller.removeListener(_handleControllerNotification);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerNotification);
    super.dispose();
  }
}
