import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/core/controller/network_controller.dart';
import 'package:flutter_bloc_prac/core/routes/app_routes.dart';
import 'package:flutter_bloc_prac/core/utils/image_picker/image_picker_utils.dart';
import 'package:flutter_bloc_prac/features/counter/bloc/counter_bloc.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/bloc/dynamic_container_bloc.dart';
import 'package:flutter_bloc_prac/features/gallery/bloc/gallery_picker_bloc.dart';

import 'features/social/data/requests/post_request.dart';
import 'features/social/domain/use_cases/post_use_case.dart';
import 'features/social/presentation/bloc/post_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const MyApp());
}

void initDependencies() {
  NetworkController.init(baseUrl: "https://jsonplaceholder.typicode.com");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => DynamicContainerBloc()),
        BlocProvider(
          create: (context) => GalleryPickerBloc(ImagePickerUtils()),
        ),
        BlocProvider(
          create: (context) =>
              PostBloc(PostUseCase(PostRequest(NetworkController.instance))),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
