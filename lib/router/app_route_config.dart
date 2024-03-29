import 'package:event_calendar_app/features/add_event/add_event.dart';
import 'package:event_calendar_app/features/home/home.dart';
import 'package:go_router/go_router.dart';

import 'app_route_name_constants.dart';

class AppRoute {
  GoRouter get router => _goRouter;

  final GoRouter _goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRouteNameConstants.homeRoutePath,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'add-event',
            name: AppRouteNameConstants.addEventRoutePath,
            builder: (context, state) => const AddEventScreen(),
          ),
        ],
      ),
    ],
  );
}
