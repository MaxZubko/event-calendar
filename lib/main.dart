import 'package:event_calendar_app/cubit/calendar_event/calendar_event_cubit.dart';
import 'package:event_calendar_app/cubit/theme/cubit/theme_cubit.dart';
import 'package:event_calendar_app/features/home/cubit/calendar_cubit.dart';
import 'package:event_calendar_app/get_it_initializer.dart';
import 'package:event_calendar_app/router/app_route_config.dart';
import 'package:event_calendar_app/services/services.dart';
import 'package:event_calendar_app/ui/ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getItInitializer();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getIt<LocalNotificationService>().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CalendarCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CalendarEventCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: state.isDark ? darkTheme : lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: getIt<AppRoute>().router,
          );
        },
      ),
    );
  }
}
