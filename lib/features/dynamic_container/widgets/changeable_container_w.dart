import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/bloc/dynamic_container_bloc.dart';

import '../bloc/dynamic_container_state.dart';

class ChangeableContainer extends StatelessWidget {
  final DynamicContainerBloc dynamicContainerBloc;

  const ChangeableContainer({super.key, required this.dynamicContainerBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DynamicContainerBloc, DynamicContainerState>(
      builder: (context, state) {
        debugPrint("Building dynamic container");
        return Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green[state.colorOpacity ?? 100],
            borderRadius: BorderRadius.circular(
              state.borderRadius?.toDouble() ?? 0,
            ),
          ),
        );
      },
    );
  }
}
