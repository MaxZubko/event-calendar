import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/cubit/calendar_event_cubit.dart';
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  getIt.registerSingleton<LocalDatabaseService>(
    LocalDatabaseService(
      sharedPrefs: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerSingleton<CalendarEventCubit>(
    CalendarEventCubit(
      service: getIt<FirestoreService>(),
      localDb: getIt<LocalDatabaseService>(),
    ),
  );
}
