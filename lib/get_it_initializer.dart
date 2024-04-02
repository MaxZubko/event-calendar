import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/cubit/calendar_event_cubit.dart';
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:get_it/get_it.dart';

import 'router/app_route_config.dart';

final getIt = GetIt.I;

void getItInitializer() {
  getIt.registerSingleton<AppRoute>(
    AppRoute(),
  );

  getIt.registerFactory<CalendarCubit>(
    () => CalendarCubit(),
  );

  getIt.registerSingleton<FirestoreService>(
    FirestoreService(db: FirebaseFirestore.instance),
  );

  getIt.registerSingleton<LocalDatabaseService>(
    LocalDatabaseService(),
  );

  // registerSingleton because you need to immediately download the list of events
  // from Firestore and save it to a variable inside Cubit for further work with it
  getIt.registerSingleton<CalendarEventCubit>(
    CalendarEventCubit(
      service: getIt<FirestoreService>(),
      localDb: LocalDatabaseService(),
    ),
  );

  GetIt.I.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());
}
