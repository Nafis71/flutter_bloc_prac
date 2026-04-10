import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/bloc/dynamic_container_bloc.dart';

import '../bloc/dynamic_container_event.dart';
import '../bloc/dynamic_container_state.dart';

class ContainerBorderRadiusSlider extends StatelessWidget {
  final DynamicContainerBloc dynamicContainerBloc;

  const ContainerBorderRadiusSlider({
    super.key,
    required this.dynamicContainerBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Border Radius", style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: 16),
        BlocBuilder<DynamicContainerBloc, DynamicContainerState>(
          buildWhen: (previous, current) =>
              previous.borderRadius != current.borderRadius ||
              (previous.enableModification != current.enableModification),
          builder: (context, state) {
            debugPrint("Building border radius slider");
            return Slider(
              value: state.borderRadius?.toDouble() ?? 1,
              max: 100,
              onChanged: state.enableModification ?? false
                  ? (sliderValue) {
                      dynamicContainerBloc.add(
                        BorderRadiusChangeEvent(sliderValue.truncate()),
                      );
                    }
                  : (_) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Modification is Disabled. Please enable it first",
                          ),
                        ),
                      );
                    },
            );
          },
        ),
      ],
    );
  }
}
