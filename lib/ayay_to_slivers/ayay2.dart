import 'package:flutter/material.dart';

/// https://dartpad-workshops-io2021.web.app/getting_started_with_slivers

void main() {
  runApp(const Ayay1());
}

class Ayay1 extends StatelessWidget {
  const Ayay1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Ayay1',
      home: const Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: [
                MyBeaches(),
                OtherPeopleBeaches(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const double heightPercent = .46;

class MyBeaches extends StatelessWidget {
  const MyBeaches({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return SliverAppBar(
      expandedHeight: screenSize.height * heightPercent,
      stretch: true,
      flexibleSpace: CustomScrollView(
        cacheExtent: screenSize.width * devicePixelRatio,
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final DailyForecast dailyForecast =
                    Server.getDailyForecastByID(index);
                return Container(
                  width: screenSize.width * .50,
                  child: Stack(
                    //this is the trick so stack can stretch
                    fit: StackFit.passthrough,
                    children: [
                      Image.network(
                        dailyForecast.imageId,
                        fit: BoxFit.cover,
                      ),
                      Placeholder(),
                    ],
                  ),
                );
              },
              childCount: _kDummyData.length,
            ),
          ),
        ],
      ),
    );
  }
}

class OtherPeopleBeaches extends StatelessWidget {
  const OtherPeopleBeaches({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return SliverGrid.builder(
      itemCount: _kDummyData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: screenSize.width / screenSize.height,
      ),
      itemBuilder: (context, index) {
        final DailyForecast dailyForecast = Server.getDailyForecastByID(index);
        return Stack(
          fit: StackFit.passthrough,
          children: [
            Image.network(
              dailyForecast.imageId,
              fit: BoxFit.cover,
            ),
            Placeholder(),
          ],
        );
      },
    );
  }
}

// --------------------------------------------
// Below this line are helper classes and data.

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/';
const String headerImage = '${baseAssetURL}assets/header.jpeg';

const Map<int, DailyForecast> _kDummyData = {
  0: DailyForecast(
    id: 0,
    imageId: '${baseAssetURL}assets/day_0.jpeg',
  ),
  1: DailyForecast(
    id: 1,
    imageId: headerImage,
  ),
  2: DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
  ),
  3: DailyForecast(
    id: 3,
    imageId: headerImage,
  ),
  4: DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
  ),
  5: DailyForecast(
    id: 5,
    imageId: headerImage,
  ),
  6: DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
  ),
  7: DailyForecast(
    id: 7,
    imageId: headerImage,
  ),
  8: DailyForecast(
    id: 8,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
  ),
  9: DailyForecast(
    id: 9,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
  ),
  10: DailyForecast(
    id: 10,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
  ),
};

class Server {
  static List<DailyForecast> getDailyForecastList() =>
      _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= _kDummyData.length - 1);
    return _kDummyData[id]!;
  }
}

class DailyForecast {
  const DailyForecast({
    required this.id,
    required this.imageId,
  });

  final int id;
  final String imageId;
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.iOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
