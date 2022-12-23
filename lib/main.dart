import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/app_route.dart';
import 'package:todo/bloc_observer.dart';
import 'package:todo/constants/app_themes/dark_theme.dart';
import 'package:todo/constants/app_themes/light_theme.dart';
import 'package:todo/data/services/local_services/notification_helper.dart';
import 'package:todo/ui/controller/theme_cubit.dart';

import 'data/services/local_services/cache_helper.dart';
import 'translations/codegen_loader.g.dart';

// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initNotification();

  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext ctx, Widget? child) {
        return BlocProvider(
          create: (context) => ThemeCubit(),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            buildWhen: (ThemeState preState, ThemeState curState) {
              return curState is SwitchAppTheme ? true : false;
            },
            builder: (context, state) {
              NotificationHelper.listener(context: context);

              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: 'Flutter ToDo',
                theme: LightTheme.theme,
                darkTheme: DarkTheme.theme,
                themeMode: ThemeCubit.get(context).getTheme,
                onGenerateRoute: AppRoute().appRoute,
                initialRoute: '/',
              );
            },
          ),
        );
      },
    );
  }
}
