import 'package:flutter/material.dart';

/// Adding To Our UI
/// Now that we’re lazily building the UI, let’s add some complexity.
/// The DailyForecast object comes with an image for each day, but we can polish
/// this a bit more.
///
/// Currently, we’re using a ListTile in the Card. This is a handy widget that
/// handles a lot of layout and padding for you. Let’s change the widget to
/// reflect our own style. Feel free to diverge here. This is a fun side
/// mission to add to the UI now that it’s more efficient.
///
/// If we look at the current UI, then we can break it into Columns and Rows,
/// and make a few adjustments.
///
/// Let’s remove the ListTile and create a Row instead. The contents of leading
/// and trailing can become children of the Row. Because title and subtitle are
/// stacked vertically, let’s wrap them in a Column and place the Column in between.
///
/// Row(
///   children: <Widget>[
///     // The former contents of our ListTile:
///     // leading
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: <Widget>[
///           // title
///           // subtitle
///       ],
///     )
///     // trailing
///   ],
/// )
/// This is pretty close to what the ListTile generated. Add some Padding to
/// neaten the UI, and put an Expanded widget around the Column to handle any
/// overflow from the forecast description.
///
/// Expanded(
///   child: Column(
///     crossAxisAlignment: CrossAxisAlignment.start,
///     children: <Widget>[
///       // title
///       // subtitle
///     ],
///   )
/// )
/// Great! Let’s add our images now. They’ll add more context to the forecasts.
/// Using a Stack, we can use the image as a background for the date.
///
/// Add a SizedBox around the Stack. The children of a Stack are stacked with
/// the first child listed on the bottom, so place the Image first, followed
/// by the Text. We’ll set a size for the Stack and Image so that they fill the
/// space of the SizedBox.
///
/// SizedBox(
///   height: 200.0,
///   width: 200.0,
///   child: Stack(
///     fit: StackFit.expand,
///     children: <Widget>[
///       Image.network(
///         dailyForecast.imageId,
///         fit: BoxFit.cover,
///       ),
///       Text(
///         dailyForecast
///           .getDate(currentDate.day)
///           .toString(),
///         style: textTheme.headline2,
///       ),
///     ],
///   ),
/// ),
/// To add some contrast between the Text and the Image, place a gradient in
/// between, for a nice visual effect. We can do this with a DecoratedBox and
/// a RadialGradient. Center the Text so it lines up with the gradient.
///
/// SizedBox(
///   height: 200.0,
///   width: 200.0,
///   child: Stack(
///     fit: StackFit.expand,
///     children: <Widget>[
///       DecoratedBox(
///         position: DecorationPosition.foreground,
///         decoration: BoxDecoration(
///           gradient: RadialGradient(
///             colors: <Color>[
///               Colors.grey[800]!,
///               Colors.transparent,
///             ],
///           ),
///         ),
///         child: Image.network(
///           dailyForecast.imageId,
///           fit: BoxFit.cover,
///         ),
///       ),
///       Center(
///         child: Text(
///           dailyForecast
///             .getDate(currentDate.day)
///             .toString(),
///           style: textTheme.headline2,
///         ),
///       ),
///     ],
///   ),
/// ),
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

    // TODO: Incorporate images from DailyForecast
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        final DailyForecast dailyForecast = Server.getDailyForecastByID(index);
        return Card(
          child: Row(
            children: [
              SizedBox(
                width: 125,
                height: 125,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.grey[800]!,
                            Colors.transparent,
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
                        style: textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dailyForecast.getWeekday(currentDate.weekday),
                        style: textTheme.headlineSmall,
                      ),
                      Text(
                        dailyForecast.description,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '${dailyForecast.highTemp} | ${dailyForecast.lowTemp} F',
                style: textTheme.titleSmall,
              ),
            ],
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
        'Partly cloudy in the morning, with sun appearing in the afternoon.kkkkkkkkkkkkkkkkkkklllllllllllllllllll',
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
