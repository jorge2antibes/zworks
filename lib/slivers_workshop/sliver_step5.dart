import 'package:flutter/material.dart';

/// https://dartpad-workshops-io2021.web.app/getting_started_with_slivers
/// Adding a SliverAppBar
/// Now that we have our CustomScrollView and SliverList in place, we can add a
/// SliverAppBar for a more dynamic header.
///
/// In the HorizonsApp, add a SliverAppBar at the top of the CustomScrollView, and
/// remove the AppBar in the Scaffold. The SliverAppBar shares similar properties
/// with the existing AppBar, so let’s migrate those too.
///
/// body: CustomScrollView(
///   slivers: <Widget>[
///     SliverAppBar(
///       title: Text('Horizons'),
///       backgroundColor: Colors.teal[800],
///     ),
///     WeeklyForecastList(),
///   ],
/// ),
///
/// We now have a scrolling app bar. This app bar scrolls as if it were part of
/// our list. The SliverAppBar has a lot more dynamic features though, so let’s explore
/// pinned, floating, snap, and collapsing behaviors for the new SliverAppBar.
///
/// Pinning the app bar keeps it at the top of the screen, like the AppBar we had before.
///
/// SliverAppBar(
///   title: Text('Horizons'),
///   backgroundColor: Colors.teal[800],
///   pinned: true,
/// ),
///
/// A floating SliverAppBar will scroll out of view, but it scrolls back into
/// view when the user scrolls back in that direction, regardless of the current
/// position in the scroll view.
///
/// SliverAppBar(
///   title: Text('Horizons'),
///   backgroundColor: Colors.teal[800],
///   floating: true,
/// ),
///
/// Floating app bars also support snap animation. This animation snaps the
/// SliverAppBar in and out of view as the user scrolls, rather than floating in
/// with the user input.
///
/// SliverAppBar(
///   title: Text('Horizons'),
///   backgroundColor: Colors.teal[800],
///   floating: true,
///   snap: true,
/// ),
///
/// Last, let’s see how the SliverAppBar behaves when we use an expandedHeight.
/// This adds to the size of the app bar and collapses as the user scrolls. The
/// expandedHeight can be combined with the floating, pinned, and snap features
/// that were discussed earlier.
///
/// SliverAppBar(
///   title: Text('Horizons'),
///   backgroundColor: Colors.teal[800],
///   pinned: true,
///   expandedHeight: 200.0,
/// ),
///
/// We can fill this extra space using a FlexibleSpaceBar. Let’s explore that in
/// the next step.
void main() {
  runApp(const HorizonsApp());
}

class HorizonsApp extends StatelessWidget {
  const HorizonsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // This is the theme of your application.
      theme: ThemeData.dark(),
      // Scrolling in Flutter behaves differently depending on the
      // ScrollBehavior. By default, ScrollBehavior changes depending
      // on the current platform. For the purposes of this scrolling
      // workshop, we're using a custom ScrollBehavior so that the
      // experience is the same for everyone - regardless of the
      // platform they are using.
      scrollBehavior: const ConstantScrollBehavior(),
      title: 'Horizons Weather',
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Horizons'),
              centerTitle: true,
              backgroundColor: Colors.amber[900]!,
              pinned: true,
              // floating: true,
              // snap: true,
              expandedHeight: 200,
              // flexibleSpace: Image.network(
              //     'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets/day_0.jpeg', fit: BoxFit.cover,),

            ),
            const WeeklyForecastList(),
          ],
        ),
      ),
    );
  }
}

class WeeklyForecastList extends StatelessWidget {
  const WeeklyForecastList({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final DailyForecast dailyForecast =
              Server.getDailyForecastByID(index);
          return Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 125.0,
                  width: 125.0,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: <Color>[
                              Colors.grey[800]!,
                              Colors.transparent
                            ],
                          ),
                        ),
                        child: Image.network(
                          dailyForecast.imageId,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Text(
                          dailyForecast.getDate(currentDate.day).toString(),
                          style: textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dailyForecast.getWeekday(currentDate.weekday),
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          dailyForecast.description,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                    style: textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 7,
      ),
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
    highTemp: 73,
    lowTemp: 52,
    description:
        'Partly cloudy in the morning, with sun appearing in the afternoon.',
  ),
  1: DailyForecast(
    id: 1,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
    highTemp: 70,
    lowTemp: 50,
    description: 'Partly sunny.',
  ),
  2: DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
    highTemp: 71,
    lowTemp: 55,
    description: 'Party cloudy.',
  ),
  3: DailyForecast(
    id: 3,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
    highTemp: 74,
    lowTemp: 60,
    description: 'Thunderstorms in the evening.',
  ),
  4: DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
    highTemp: 67,
    lowTemp: 60,
    description: 'Severe thunderstorm warning.',
  ),
  5: DailyForecast(
    id: 5,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
    highTemp: 73,
    lowTemp: 57,
    description: 'Cloudy with showers in the morning.',
  ),
  6: DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
    highTemp: 75,
    lowTemp: 58,
    description: 'Sun throughout the day.',
  ),
};

class Server {
  static List<DailyForecast> getDailyForecastList() =>
      _kDummyData.values.toList();

  static DailyForecast getDailyForecastByID(int id) {
    assert(id >= 0 && id <= 6);
    return _kDummyData[id]!;
  }
}

class DailyForecast {
  const DailyForecast({
    required this.id,
    required this.imageId,
    required this.highTemp,
    required this.lowTemp,
    required this.description,
  });

  final int id;
  final String imageId;
  final int highTemp;
  final int lowTemp;
  final String description;

  static const List<String> _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String getWeekday(int today) {
    final int offset = today + id;
    final int day = offset >= 7 ? offset - 7 : offset;
    return _weekdays[day];
  }

  int getDate(int today) => today + id;
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
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
