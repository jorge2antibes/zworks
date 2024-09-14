import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sbox1/swipe_detector/flutter_swipe_detector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Accessibility and internationalization
///https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
/// In the arb files, the key of each entry is used as the method name of the getter, while
/// the value of that entry contains the localized message.
/// To localize your device app description, pass the localized string to
/// MaterialApp.onGenerateTitle
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      locale: Locale('en'),
      onGenerateTitle: (context) => AppLocalizations.of(context)?.title ?? 'No title provided',
      title: 'Localizations Sample App',
      // localizationsDelegates: [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: [
      //   Locale('en'), // English
      //   Locale('es'), // Spanish
      // ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyHomePage(title: 'localizations01'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add the following code
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              // Using a Builder to get the correct BuildContext.
              // Alternatively, you can create a new widget and Localizations.override
              // will pass the updated BuildContext to the new widget.
              child: Builder(
                builder: (context) {
                  // A toy example for an internationalized Material widget.
                  return CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    onDateChanged: (value) {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


