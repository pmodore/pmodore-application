import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pomodore/core/constant/constant.dart';
import 'package:pomodore/core/router/router.dart';
import 'package:pomodore/core/utils/bloc_observer.dart';
import 'package:pomodore/di.dart';
import 'package:pomodore/features/configuration/presentation/blocs/base_bloc/base_bloc.dart';

import 'core/utils/size_config.dart';
import 'features/task_management/presentation/blocs/timer_bloc/timer_bloc.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(statusBarIconBrightness: Brightness.light));

  // Dependency injection
  await inject();

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());

  // some setting to config Desktop version
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    doWhenWindowReady(() {
      const initialSize = Size(400, 700);
      appWindow.minSize = initialSize;
      appWindow.maxSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.centerRight;
      appWindow.title = AppConstant.appName;
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerBloc>(
          create: (context) => getIt.get<TimerBloc>(),
        ),
        BlocProvider<BaseBloc>(
          create: (context) => getIt.get<BaseBloc>(),
        ),
      ],
      child: OrientationBuilder(
        builder: (context, orientation) =>
            LayoutBuilder(builder: (context, constraints) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            title: AppConstant.appName,
            onGenerateRoute: AppRouter.onGenerationRouter,
            theme: AppConstant.getTheme(context),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('fa'),
              Locale('de'),
            ],
            locale: const Locale('en'),
          );
        }),
      ),
    );
  }
}
