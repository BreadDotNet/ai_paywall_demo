import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../i18n/strings.g.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/di/di_container.dart';
import '../../application/bloc/app_session_cubit.dart';

final class App extends StatelessWidget {
  const App({required this.container, required this.router, super.key});

  final DIContainer container;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    final config = container.get<AppConfig>();

    return RepositoryProvider<DIContainer>.value(
      value: container,
      child: BlocProvider<AppSessionCubit>.value(
        value: container.get<AppSessionCubit>(),
        child: TranslationProvider(
          child: Builder(
            builder: (context) {
              return MaterialApp.router(
                title: config.appName,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF3366CC),
                  ),
                  cardTheme: const CardThemeData(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                  ),
                  filledButtonTheme: FilledButtonThemeData(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                locale: TranslationProvider.of(context).flutterLocale,
                supportedLocales: AppLocaleUtils.supportedLocales,
                localizationsDelegates: GlobalMaterialLocalizations.delegates,
                routerConfig: router,
              );
            },
          ),
        ),
      ),
    );
  }
}
