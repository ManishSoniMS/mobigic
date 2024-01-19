import 'package:go_router/go_router.dart';

import '../src/features/grid/presentation/pages/home_page.dart';
import '../src/features/grid/presentation/pages/table_page.dart';
import '../src/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._();

  static AppRouter get instance => _instance;

  late GoRouter _router;

  GoRouter get router => _router;

  AppRouter._() {
    _router = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          name: "Splash",
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: "/home",
          name: "Home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: "/table",
          name: "Table",
          builder: (context, state) => const TablePage(),
        ),
      ],
    );
  }
}
