import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_prac/core/routes/route_names.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer(Duration(seconds: 2), (){
      context.goNamed(RouteNames.counter);
      _timer.cancel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
