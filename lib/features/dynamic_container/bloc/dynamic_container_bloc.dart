import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/bloc/dynamic_container_event.dart';
import 'package:flutter_bloc_prac/features/dynamic_container/bloc/dynamic_container_state.dart';

class DynamicContainerBloc
    extends Bloc<DynamicContainerEvent, DynamicContainerState> {
  DynamicContainerBloc() : super(DynamicContainerState()) {
    on<EnableContainerModificationEvent>(_enableContainerModification);
    on<BorderRadiusChangeEvent>(_changeContainerBorderRadius);
    on<ColorOpacityChangeEvent>(_changeContainerColorOpacity);
  }

  void _enableContainerModification(
    EnableContainerModificationEvent event,
    Emitter<DynamicContainerState> emit,
  ) {
    emit(state.copyWith(enableModification: event.enable));
  }

  void _changeContainerBorderRadius(
    BorderRadiusChangeEvent event,
    Emitter<DynamicContainerState> emit,
  ) {
    emit(state.copyWith(borderRadius: event.selectedBorderRadius));
  }

  void _changeContainerColorOpacity(
    ColorOpacityChangeEvent event,
    Emitter<DynamicContainerState> emit,
  ) {
    emit(state.copyWith(colorOpacity: event.selectedColorOpacity));
  }
}
