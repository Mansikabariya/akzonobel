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
          create:
              (context) => HomeRepository(
                appApiService: RepositoryProvider.of<AppApiService>(context),
                localStorage: LocalStorage.shared,
              ),
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
            create: (context) =>
                HomePageBloc(homeRepository: context.read<HomeRepository>()),
          ),

        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? home;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final isLoggedIn = await LocalStorage.shared.isLoggedIn();
    if (isLoggedIn) {
      final userData = await LocalStorage.shared.getUserData();
      context.read<HomePageBloc>().add(FetchEvent(type: '1', offset: '0'));
      home = HomeScreen(userData: userData!);
    } else {
      home = const LoginScreen();
    }

    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      onGenerateRoute: onGeneratesAppRoutes,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.red,
          tertiary: Colors.yellow,
        ),
        useMaterial3: true,
        textTheme: TTextTheme.lightTheme,
        elevatedButtonTheme: TElevatedButtonTheme.lightButtonTheme,
        appBarTheme: TAppBarTheme.lightAppBarTheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home:
          _isLoading ? const Center(child: CircularProgressIndicator()) : home,
    );
  }
}
