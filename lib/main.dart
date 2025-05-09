import 'package:akzonobel/core/service/api_service.dart';
import 'package:akzonobel/home_page/bloc/home_page_bloc.dart';
import 'package:akzonobel/home_page/bloc/home_page_event.dart';
import 'package:akzonobel/home_page/home_screen.dart';
import 'package:akzonobel/home_page/repository/home_repository.dart';
import 'package:akzonobel/l10n/l10n.dart';
import 'package:akzonobel/login/model/user_data.dart';
import 'package:akzonobel/login/repository/login_repository.dart';
import 'package:akzonobel/utils/route_utils.dart';
import 'package:akzonobel/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/local_storage/local_storage.dart';
import 'login/bloc/login_bloc.dart';
import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LocalStorage
  await LocalStorage.initialize();
  final appApiService = AppApiService.create(localStorage: LocalStorage.shared);

  runApp(
    MultiRepositoryProvider(
      providers: [
        // Provide the AppApiService instance
        RepositoryProvider<AppApiService>(create: (context) => appApiService),
        // Provide the AuthRepository instance
        RepositoryProvider<AuthRepository>(
          create:
              (context) => AuthRepository(
                appApiService: RepositoryProvider.of<AppApiService>(context),
                localStorage: LocalStorage.shared,
              ),
        ),
        // Provide the HomeRepository instance
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(appApiService: RepositoryProvider.of<AppApiService>(context), localStorage: LocalStorage.shared),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    LoginBloc(authRepository: RepositoryProvider.of(context)),
          ),
          BlocProvider(
            create: (context) => HomePageBloc(
              homeRepository: context.read<HomeRepository>(),
            )..add(FetchEvent(type: '1', offset: '0')),
            child: HomeScreen(userData: UserData()),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGeneratesAppRoutes,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TTextTheme.lightTheme,
        elevatedButtonTheme: TElevatedButtonTheme.lightButtonTheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home:
      LocalStorage.shared.isLoggedIn
          ? const HomeScreen(userData: UserData(),)
          : const LoginScreen(),
      // const LoginScreen(),

    );
  }
}
