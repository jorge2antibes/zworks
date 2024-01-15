import 'package:flutter/material.dart';

/// Efficient scrolling in Flutter
/// The first task is to convert the SingleChildScrollView to make our scrolling
/// UI more efficient, but first, let's discuss why and when this widget might
/// not be the most efficient choice.
///
/// Currently, the UI is pretty simple. The scrolling 7-day forecast is likely
/// to fit most screens. This is OK for now, but as we add to the UI, we want to remain performant.
///
/// If we remove the SingleChildScrollView, then we could get an error due to the
/// Column overflowing. If you want to, try and see what this looks like by resizing
/// the window so that the contents of the Column don’t fit in the screen.
///
/// This is where we can see how the layout protocol of slivers differs from their
/// relative, the box layout protocol. A Column is laid out using BoxConstraints.
/// It has a height and width, and a position within the window. A Column cannot
/// lay out beyond the bounds of the window.
///
/// When we wrap the Column in a SingleChildScrollView, we’re essentially wrapping
/// the Column in a sliver. Slivers lay out using SliverContraints and have a
/// SliverGeometry. When you work with slivers, the window size that we were
/// constricted to previously becomes an infinite amount of space in the given
/// axis. So, we use language different from height, width, and position. For a
/// sliver, we need to know things like how much is visible, how far to the next
/// sliver, and how far we scrolled. The answers enable us to lazily load slivers,
/// meaning we only build slivers that we can see and a little bit of the ones on
/// either edge. This makes scrolling more efficient because we won’t build slivers
/// that we don’t need because the slivers aren’t seen.
///
/// Making the switch
/// Because a SingleChildScrollView is only one sliver, we aren’t lazily loading
/// the UI. Instead, as the Column gets bigger, all of its contents are built.
/// Before we add more to the UI, let’s make it more efficient by using ListView.
///
/// We’ll use the builder constructor, which is called on demand, for lazy loading.
///
/// Replace the SingleChildScrollView with the ListView.builder, and remove the
/// Column. This constructor requires an itemBuilder, which provides a BuildContext
/// and the current item index. We must also specify the itemCount because we know
/// that we’re displaying a weekly forecast.
///
/// return ListView.builder(
///   itemCount: 7,
///   itemBuilder: (BuildContext context, int index) {
///     return Card(
///       // This remains unchanged.
///     );
///   }
/// );
/// Now each of the Cards is wrapped in a sliver and only built as it’s needed.
///
/// We’re also going to change the access to the mock Server class. Rather than request all of the data at one time, we can access the forecasts by index in our builder.
///
/// // Remove this:
/// final List<DailyForecast> forecasts =
///     Server.getDailyForecastList();
///
/// // And add this in our ListView itemBuilder
/// final DailyForecast dailyForecast =
///     Server.getDailyForecastByID(index);
/// Now that we’re building more efficiently, let’s add more to the ListView.
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

    // TODO: Let's make this a more efficient Scrollable before we
    //  add more widgets.
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final dailyForecast = Server.getDailyForecastByID(index);

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
    highTemp: 73,
    lowTemp: 52,
    description:
    'Partly cloudy in the morning, with sun appearing in the afternoon.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  1: DailyForecast(
    id: 1,
    imageId: '${baseAssetURL}assets/day_1.jpeg',
    highTemp: 70,
    lowTemp: 50,
    description: 'Partly sunny.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  2: DailyForecast(
    id: 2,
    imageId: '${baseAssetURL}assets/day_2.jpeg',
    highTemp: 71,
    lowTemp: 55,
    description: 'Party cloudy.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  3: DailyForecast(
    id: 3,
    imageId: '${baseAssetURL}assets/day_3.jpeg',
    highTemp: 74,
    lowTemp: 60,
    description: 'Thunderstorms in the evening.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  4: DailyForecast(
    id: 4,
    imageId: '${baseAssetURL}assets/day_4.jpeg',
    highTemp: 67,
    lowTemp: 60,
    description: 'Severe thunderstorm warning.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  5: DailyForecast(
    id: 5,
    imageId: '${baseAssetURL}assets/day_5.jpeg',
    highTemp: 73,
    lowTemp: 57,
    description: 'Cloudy with showers in the morning.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
  ),
  6: DailyForecast(
    id: 6,
    imageId: '${baseAssetURL}assets/day_6.jpeg',
    highTemp: 75,
    lowTemp: 58,
    description: 'Sun throughout the day.lkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjllkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkjlkljlkjlkjlkjlkjlkjlkjl',
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
