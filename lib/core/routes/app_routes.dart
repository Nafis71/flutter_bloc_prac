import 'package:flutter_bloc_prac/core/routes/route_names.dart';
import 'package:flutter_bloc_prac/features/counter/pages/counter_v.dart';
import 'package:flutter_bloc_prac/features/splash/pages/splash_v.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: RouteNames.initial,
        builder: (context, state) {
          return SplashView();
        },
      ),
      GoRoute(
        path: "/counter",
        name: RouteNames.counter,
        builder: (context, state) {
          return CounterView();
        },
      ),
    ],
  );
}
