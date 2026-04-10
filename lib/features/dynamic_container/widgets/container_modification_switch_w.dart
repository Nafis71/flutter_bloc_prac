import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dynamic_container_bloc.dart';
import '../bloc/dynamic_container_event.dart';
import '../bloc/dynamic_container_state.dart';

class ContainerModificationSwitch extends StatelessWidget {
  final DynamicContainerBloc dynamicContainerBloc;

  const ContainerModificationSwitch({
    super.key,
    required this.dynamicContainerBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          "Enable Modification",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        BlocBuilder<DynamicContainerBloc, DynamicContainerState>(
          buildWhen: (previous, current) =>
              previous.enableModification != current.enableModification,
          builder: (context, state) {
            debugPrint("Building switch");
            return Switch(
              value: state.enableModification ?? false,
              onChanged: (value) => dynamicContainerBloc.add(
                EnableContainerModificationEvent(value),
              ),
            );
          },
        ),
      ],
    );
  }
}
