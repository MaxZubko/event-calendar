import 'package:event_calendar_app/features/event_details/event_details.dart';
import 'package:event_calendar_app/features/home/home.dart';
import 'package:event_calendar_app/services/firestore_service/models/models.dart';
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
  );
}
