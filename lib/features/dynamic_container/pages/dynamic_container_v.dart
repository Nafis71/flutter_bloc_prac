import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/bloc/dynamic_container_bloc.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/widgets/changeable_container_w.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/widgets/container_border_radius_slider_w.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/widgets/container_color_opacity_slider_w.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/widgets/container_modification_switch_w.dart';

class DynamicContainerView extends StatefulWidget {
  const DynamicContainerView({super.key});

  @override
  State<DynamicContainerView> createState() => _DynamicContainerViewState();
}

class _DynamicContainerViewState extends State<DynamicContainerView> {
  late final DynamicContainerBloc _dynamicContainerBloc;

  @override
  void initState() {
    _dynamicContainerBloc = context.read<DynamicContainerBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dynamic Container",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            ContainerModificationSwitch(
              dynamicContainerBloc: _dynamicContainerBloc,
            ),
            SizedBox(height: 30),
            ChangeableContainer(dynamicContainerBloc: _dynamicContainerBloc),
            SizedBox(height: 30),
            ContainerBorderRadiusSlider(
              dynamicContainerBloc: _dynamicContainerBloc,
            ),
            SizedBox(height: 16),
            ContainerColorOpacitySlider(
              dynamicContainerBloc: _dynamicContainerBloc,
            ),
          ],
        ),
      ),
    );
  }
}
