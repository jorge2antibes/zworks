import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

final router = GoOnRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'router.onExit',
      theme: _buildTheme(context),
      scrollBehavior: const ConstantScrollBehavior(),
      routerConfig: router,
    );
  }
}

class GoOnRouter extends GoRouter {
  GoOnRouter()
      : super.routingConfig(
            routingConfig: routingConfigState,
            refreshListenable: null,
            debugLogDiagnostics: true,
            observers: <NavigatorObserver>[NavigationObserver()]);

  static final routingConfigState = ValueNotifier<RoutingConfig>(
    RoutingConfig(
      redirect: (context, state) async {
        // todo: Before v12 this callback was configure in the GoRouter factory constructor,
        // todo: now being move to RoutingConfig
        return null;
      },
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          name: '/',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            name: state.name,
            arguments: <String, dynamic>{
              'name': state.name,
              'path': state.path,
            },
            child: const rootPg(),
          ),
          routes: <GoRoute>[
            GoRoute(
              path: 'that_route',
              name: '/that_route',
              /// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/on_exit.dart
              onExit: (context, state) async {
                final canGoBack = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Are you sure to leave this page'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Confirm'),
                      ),
                    ],
                  ),
                );
                return canGoBack ?? false;
              },
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                name: state.name,
                arguments: <String, dynamic>{
                  'name': state.name,
                  'path': state.path,
                },
                child: const ThatPg(),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class rootPg extends StatelessWidget {
  const rootPg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 300,
          child: TextButton(
            onPressed: () => router.go('/that_route'),
            child: const Placeholder(
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class ThatPg extends StatelessWidget {
  const ThatPg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          child: Placeholder(
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}

class NavigationObserver extends NavigatorObserver {
  @override
  void didStopUserGesture() {
    debugPrint(
      'NavigationObserver.didStopUserGesture()',
    );
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      '''NavigationObserver.didStartUserGesture(): 
      route.settings.name: ${route.settings.name}, 
      route.settings.arguments: ${route.settings.arguments}''',
    );
    debugPrint(
      '''NavigationObserver.didStartUserGesture(): 
      route.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.settings.arguments: ${previousRoute?.settings.arguments}''',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
      '''NavigationObserver.didReplace(): 
      route.settings.name: ${newRoute?.settings.name}, 
      route.settings.arguments: ${newRoute?.settings.arguments}''',
    );
    debugPrint(
      '''NavigationObserver.didReplace(): 
      route.settings.name: ${oldRoute?.settings.name}, 
      previousRoute.settings.arguments: ${oldRoute?.settings.arguments}''',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      '''NavigationObserver.didRemove(): 
      route.settings.name: ${route.settings.name}, 
      route.settings.arguments: ${route.settings.arguments}''',
    );
    debugPrint(
      '''NavigationObserver.didRemove(): 
      route.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.settings.arguments: ${previousRoute?.settings.arguments}''',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      '''NavigationObserver.didPop(): 
      route.settings.name: ${route.settings.name}, 
      route.settings.arguments: ${route.settings.arguments}''',
    );
    debugPrint(
      '''NavigationObserver.didPop(): 
      previousRoute.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.settings.arguments: ${previousRoute?.settings.arguments}''',
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      '''NavigationObserver.didPush(): 
      route.settings.name: ${route.settings.name}, 
      route.arguments: ${route.settings.arguments}''',
    );
    debugPrint(
      '''NavigationObserver.didPush(): 
      previousRoute.settings.name: ${previousRoute?.settings.name}, 
      route.arguments: ${previousRoute?.settings.arguments}''',
    );
  }
}

///https://pub.dev/packages/google_fonts
///https://www.flutterbeads.com/change-theme-text-color-in-flutter/#:~:text=of%20adding%20color-,Steps%20to%20change%20theme%20text%20color%20in%20Flutter,the%20color%20of%20your%20choice.
ThemeData _buildTheme(BuildContext context) {
  var baseTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
    primarySwatch: Colors.blue,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.poiretOneTextTheme(baseTheme.textTheme),
    // textTheme: GoogleFonts.juraTextTheme(baseTheme.textTheme),
  );
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  //originally macos
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.iOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
