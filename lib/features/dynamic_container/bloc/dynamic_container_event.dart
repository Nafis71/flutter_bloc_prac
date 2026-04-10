import 'package:equatable/equatable.dart';

abstract class DynamicContainerEvent extends Equatable {
  const DynamicContainerEvent();

  @override
  List<Object?> get props => [];
}

class EnableContainerModificationEvent extends DynamicContainerEvent {
  final bool enable;

  const EnableContainerModificationEvent(this.enable);

  @override
  List<Object?> get props => [enable];
}

class BorderRadiusChangeEvent extends DynamicContainerEvent {
  final int selectedBorderRadius;

  const BorderRadiusChangeEvent(this.selectedBorderRadius);

  @override
  List<Object?> get props => [selectedBorderRadius];
}

class ColorOpacityChangeEvent extends DynamicContainerEvent {
  final int selectedColorOpacity;

  const ColorOpacityChangeEvent(this.selectedColorOpacity);

  @override
  List<Object?> get props => [selectedColorOpacity];
}
