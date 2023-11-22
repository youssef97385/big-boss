// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
//
//
// class RouterObserver extends AutoRouterObserver {
//   // FirebaseAnalyticsManager firebaseAnalyticsManager;
//
//
//
//   void sendScreenView(String screenName) {
//     // firebaseAnalyticsManager.setTrackingScreen(screenName);
//   }
//
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPush(route, previousRoute);
//     if (route is PageRoute) {
//       final String screenName = route.settings.name ?? "";
//       sendScreenView(screenName);
//     }
//   }
//
//   @override
//   void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//     if (newRoute is PageRoute) {
//       final String screenName = newRoute.settings.name ?? "";
//       sendScreenView(screenName);
//     }
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     super.didPop(route, previousRoute);
//     if (previousRoute is PageRoute && route is PageRoute) {
//       final String screenName = route.settings.name ?? "";
//       sendScreenView(screenName);
//     }
//   }
//
//   @override
//   void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
//     super.didInitTabRoute(route, previousRoute);
//     final String screenName = route.name;
//     sendScreenView(screenName);
//   }
//
//   @override
//   void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
//     super.didChangeTabRoute(route, previousRoute);
//     final String screenName = route.name;
//     sendScreenView(screenName);
//   }
// }
