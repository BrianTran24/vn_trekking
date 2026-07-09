import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'presentation/routing/router.dart';
import 'application/auth/auth_bloc.dart';
import 'infrastructure/auth/mock_auth_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(repository: MockAuthRepository()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          fontFamily: 'Roboto', // Assuming standard font
        ),
      ),
    );
  }
}
