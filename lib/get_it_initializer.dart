import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_calendar_app/cubit/calendar_event/calendar_event_cubit.dart';
import 'package:event_calendar_app/cubit/theme/cubit/theme_cubit.dart';
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:get_it/get_it.dart';

import 'repositories/doc_id_repository/doc_id.dart';
import 'repositories/settings_repository/settings.dart';
import 'router/app_route_config.dart';

final getIt = GetIt.I;

void getItInitializer() async {
  getIt.registerSingleton<AppRoute>(
    AppRoute(),
  );

  getIt.registerFactory<CalendarCubit>(
    () => CalendarCubit(),
  );

  getIt.registerSingleton<FirestoreService>(
    FirestoreService(db: FirebaseFirestore.instance),
  );

  // getIt.registerSingletonAsync(() async => SharedPreferences.getInstance());
  // await getIt.isReady<SharedPreferences>();

  getIt.registerSingleton<DocIdRepository>(
    DocIdRepository(),
  );

  // registerSingleton because you need to immediately download the list of events
  // from Firestore and save it to a variable inside Cubit for further work with it
  getIt.registerSingleton<CalendarEventCubit>(
    CalendarEventCubit(
      service: getIt<FirestoreService>(),
      localDb: DocIdRepository(),
    ),
  );

  getIt.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());

  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepository(),
  );

  getIt.registerFactory<ThemeCubit>(
    () => ThemeCubit(
      settingsRepository: getIt<SettingsRepository>(),
    ),
  );
}
