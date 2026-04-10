import 'package:flutter_bloc_prac/core/routes/route_names.dart';
import 'package:flutter_bloc_prac/features/counter/pages/counter_v.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/pages/dynamic_container_v.dart';
import 'package:flutter_bloc_prac/features/gallery/pages/gallery_v.dart';
import 'package:flutter_bloc_prac/features/splash/pages/splash_v.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter router = GoRouter(
    initialLocation: RouteNames.initial,
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
      GoRoute(
        path: "/dynamic-container",
        name: RouteNames.dynamicContainer,
        builder: (context, state) {
          return DynamicContainerView();
        },
      ),
      GoRoute(
        path: "/gallery",
        name: RouteNames.gallery,
        builder: (context, state) {
          return GalleryView();
        },
      ),
    ],
  );
}
