import 'package:flutter/material.dart';

/// Introduction
/// Welcome to the introductory sliver workshop for Flutter! 👋
///
/// In this workshop, you will learn how to efficiently build scrolling widgets
/// and use slivers directly, to create a rich scrolling experience for users.
///
/// This workshop is best for folks already familiar with building simple Flutter
/// applications. If this is your first time using Flutter, then check out Writing
/// your first Flutter app to get started using Flutter.
///
/// What is a sliver?
///
/// A sliver is a portion of a scrollable area, which means anything that scrolls
/// in Flutter is a sliver. If you've used ListView or GridView, congratulations!
/// You've already used a sliver in your Flutter app. Most often, slivers are wrapped
/// in convenience classes such as these. This is because slivers use a different
/// layout protocol from most other widgets in the Flutter framework. We'll discuss
/// layout protocol later in the workshop. For now, let's take a tour of our starter code.
///
/// Simple scrolling UI
///
/// Here, we have a forecasting app, called Horizons.
///
/// This MaterialApp consists of a Scaffold with a WeeklyForecastList as the body.
/// This widget consists of a SingleChildScrollView that contains a Column featuring
/// the next 7-day forecast.
///
/// SingleChildScrollView(
///   child: Column(
///     children: <Widget>[
///       /* Our 7 day forecast */
///     ],
///   ),
/// );
///
/// We also have our own ScrollBehavior set for our app.
///
/// MaterialApp(
///
///   scrollBehavior: ConstantScrollBehavior(),
///   // ...
/// )
///
/// ScrollBehaviors are inherited by descendent Scrollables. They inform a Scrollable's
/// ScrollPhysics and apply decorations like Scrollbars and GlowingOverscrollIndicators.
///
/// By default, ScrollBehaviors are dynamic and change depending on the current platform
/// that you're running this workshop on, like ScrollPhysics. On Mac and iOS platforms,
/// you'll see BouncingScrollPhysics by default, while on others you'll see ClampingScrollPhysics.
/// To provide a consistent experience for everyone taking this workshop, we added a
/// custom ScrollBehavior.
///
/// Where to next?
/// Throughout this workshop, we'll build on this code. We’ll convert the SingleChildScrollView
/// to be a more efficient, lazy loading ListView.This allows us to add more to our
/// app and remain performant.
///
/// We’ll then dive a little deeper and transform the code to use slivers directly,
/// and we’ll experiment with dynamic scrolling effects like floating app bars. Move
/// on to the next step to begin!

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
        appBar: AppBar(
          title: const Text('Horizons'),
          backgroundColor: Colors.teal[800],
        ),
        body: const WeeklyForecastList(),
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
    final List<DailyForecast> forecasts = Server.getDailyForecastList();

    return SingleChildScrollView(
      child: Column(
        children: forecasts.map((dailyForecast) {
          return Card(
            child: ListTile(
              leading: Text(
                dailyForecast.getDate(currentDate.day).toString(),
                style: textTheme.headlineMedium,
              ),
              title: Text(
                dailyForecast.getWeekday(currentDate.weekday),
                style: textTheme.headlineSmall,
              ),
              subtitle: Text(dailyForecast.description),
              trailing: Text(
                '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                style: textTheme.titleSmall,
              ),
            ),
          );
        }).toList(),
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
    description: 'Partly sunny.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  2: DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
    highTemp: 71,
    lowTemp: 55,
    description: 'Party cloudy.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  3: DailyForecast(
    id: 3,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
    highTemp: 74,
    lowTemp: 60,
    description: 'Thunderstorms in the evening.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  4: DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
    highTemp: 67,
    lowTemp: 60,
    description: 'Severe thunderstorm warning.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  5: DailyForecast(
    id: 5,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
    highTemp: 73,
    lowTemp: 57,
    description: 'Cloudy with showers in the morning.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  6: DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
    highTemp: 75,
    lowTemp: 58,
    description: 'Sun throughout the day.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
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
