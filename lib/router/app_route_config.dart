import 'package:event_calendar_app/features/event_details/event_details.dart';
import 'package:event_calendar_app/features/home/home.dart';
import 'package:event_calendar_app/features/settings/settings.dart';
import 'package:event_calendar_app/services/firestore_service/models/models.dart';
import 'package:event_calendar_app/wrapper/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route_name_constants.dart';

class AppRoute {
  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

  GoRouter get router => _goRouter;

  final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/",
                name: AppRouteNameConstants.homeRoutePath,
                builder: (BuildContext context, GoRouterState state) =>
                    const HomeScreen(),
                routes: [
                  GoRoute(
                    path: 'event-details',
                    name: AppRouteNameConstants.eventDetailsRoutePath,
                    builder: (context, state) {
                      final model = state.extra as CalendarEventModel;

                      return EventDetailsScreen(
                        eventModel: model,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettings,
            routes: <RouteBase>[
              GoRoute(
                path: "/settings",
                name: "Settings",
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
