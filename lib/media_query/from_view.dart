

// https://stackoverflow.com/questions/76226720/migrate-from-mediaquery-fromwindow-to-mediaquery-fromview

// without context
// views can be [single, fist, last, firstOrNull]
// import 'package:flutter/cupertino.dart';
//
// final MediaQueryData data = MediaQueryData.fromView(WidgetsFlutterBinding.ensureInitialized().platformDispatcher.views.single);

/// With Context
/// Basically - View.of(context) === WidgetsBinding.instance.window
/// Examples:
//  final double dpr = View.of(context).devicePixelRatio;
//  final Locale locale = View.of(context).platformDispatcher.locale;
//
// MediaQuery.fromView(view: View.of(context),
// child: ...
// )