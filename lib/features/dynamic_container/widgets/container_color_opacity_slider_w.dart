import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dynamic_container_bloc.dart';
import '../bloc/dynamic_container_event.dart';
import '../bloc/dynamic_container_state.dart';

class ContainerColorOpacitySlider extends StatelessWidget {
  final DynamicContainerBloc dynamicContainerBloc;

  const ContainerColorOpacitySlider({
    super.key,
    required this.dynamicContainerBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Color Opacity", style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: 16),
        BlocBuilder<DynamicContainerBloc, DynamicContainerState>(
          buildWhen: (previous, current) =>
              previous.colorOpacity != current.colorOpacity ||
              (previous.enableModification != current.enableModification),
          builder: (context, state) {
            debugPrint("Building Color Opacity slider");
            return Slider(
              value: state.colorOpacity?.toDouble() ?? 100,
              max: 900,
              divisions: 9,
              onChanged: state.enableModification ?? false
                  ? (sliderValue) {
                      dynamicContainerBloc.add(
                        ColorOpacityChangeEvent(sliderValue.toInt()),
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
