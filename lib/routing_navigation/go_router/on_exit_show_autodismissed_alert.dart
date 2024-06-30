// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// This sample app demonstrates how to use GoRoute.onExit.
/// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/on_exit.dart
void main() => runApp(const MyApp());

/// The route configuration.
final GoRouter _router = GoRouter(
  observers: <NavigatorObserver>[NavigationObserver()],
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'root',
      onExit: (context, state) async {
        print('''onExit: state: values:
                state.extra: ${state.extra},
                state.path: ${state.path},
                state.name: ${state.name},
                state.error: ${state.error},
                state.fullPath: ${state.fullPath},
                state.matchedLocation: ${state.matchedLocation},
                state.pathParameters: ${state.pathParameters},
                state.topRoute: ${state.topRoute},
                state.uri: ${state.uri},
                ''');
        final formKeyValidates = true ? true : false;
        return formKeyValidates;
      },
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          name: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
          onExit: (
            BuildContext context,
            GoRouterState state,
          ) async {
            print('''onExit: state: values:
                state.extra: ${state.extra},
                state.path: ${state.path},
                state.name: ${state.name},
                state.error: ${state.error},
                state.fullPath: ${state.fullPath},
                state.matchedLocation: ${state.matchedLocation},
                state.pathParameters: ${state.pathParameters},
                state.topRoute: ${state.topRoute},
                state.uri: ${state.uri},
                ''');
            // final formKeyValidates = true ? true : false;
            // return formKeyValidates;
            //   // final validated = true;
            //   // return validated;
            //   // if(validated){
            //   //   print('onExit(): returns true');
            //   //   return validated;
            //   // } else {
            //   //   return validated;
            //   // }
              final bool? confirmed = await showDialog<bool>(
                barrierColor: Colors.green,
                barrierDismissible: true,
                context: context,
                builder: (_) {
                  final validate = false;
                  // Schedule a delayed dismissal of the alert dialog after 3 seconds
                  if (validate) {
                    Navigator.of(context).pop('true');
                  } else {
                    final timer = Timer(Duration(seconds: 3), () {
                      if (validate) {
                        Navigator.of(context).pop(true); // Close the dialog
                      } else {
                        Navigator.of(context).pop(false); // Close the dialog
                      }
                    });
                  }
                  return AlertDialog(
                    content: validate ? const Text('data') : const Text('Are you sure to leave this page?'),
                  );
                },
              );
              return confirmed ?? false;
          },
        ),
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
        ),
      ],
    ),
  ],
);

class NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      '''NavigationObserver.didPush():
       route.settings.name: ${route.settings.name}, 
       route.arguments: ${route.settings.arguments}''',
    );
    print(
      '''NavigationObserver.didPush(): 
      previousRoute.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.arguments: ${previousRoute?.settings.arguments}''',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      '''NavigationObserver.didPop(): 
      route.settings.name: ${route.settings.name}, 
      route.settings.arguments: ${route.settings.arguments}''',
    );
    print(
      '''NavigationObserver.didPop(): 
      previousRoute.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.settings.arguments: ${previousRoute?.settings.arguments}''',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print(
      '''NavigationObserver.didReplace(): 
      newRoute.settings.name: ${newRoute?.settings.name}, 
      newRoute.settings.arguments: ${newRoute?.settings.arguments}''',
    );
    print(
      '''NavigationObserver.didReplace(): 
      oldRoute.settings.name: ${oldRoute?.settings.name}, 
      oldRoute.settings.arguments: ${oldRoute?.settings.arguments}''',
    );
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      '''NavigationObserver.didStartUserGesture(): 
      route.settings.name: ${route.settings.name}, 
      route.settings.arguments: ${route.settings.arguments}''',
    );
    print(
      '''NavigationObserver.didStartUserGesture(): 
      previousRoute.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.settings.arguments: ${previousRoute?.settings.arguments}''',
    );
  }

  @override
  void didStopUserGesture() {
    print(
      'NavigationObserver.didStopUserGesture()',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      '''NavigationObserver.didRemove():
       route.settings.name: ${route.settings.name}, 
       route.settings.arguments: ${route.settings.arguments}''',
    );
    print(
      '''NavigationObserver.didRemove(): 
      previousRoute.settings.name: ${previousRoute?.settings.name}, 
      previousRoute.settings.arguments: ${previousRoute?.settings.arguments}''',
    );
  }
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

/// The home screen
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => context.go('/details'),
              child: const Text('Go to the Details screen'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
          child: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('go back'),
          ),
          TextButton(
            onPressed: () {
              context.go('/settings');
            },
            child: const Text('go to settings'),
          ),
        ],
      )),
    );
  }
}

/// The settings screen
class SettingsScreen extends StatelessWidget {
  /// Constructs a [SettingsScreen]
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen')),
      body: const Center(
        child: Text('Settings'),
      ),
    );
  }
}
