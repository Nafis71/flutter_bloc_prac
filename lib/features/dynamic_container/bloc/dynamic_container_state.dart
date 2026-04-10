import 'package:equatable/equatable.dart';

class DynamicContainerState extends Equatable {
  final bool? enableModification;
  final int? borderRadius;
  final int? colorOpacity;

  const DynamicContainerState({
    this.enableModification,
    this.borderRadius,
    this.colorOpacity,
  });

  @override
  List<Object?> get props => [enableModification, borderRadius, colorOpacity];

  DynamicContainerState copyWith({
    bool? enableModification,
    int? borderRadius,
    int? colorOpacity,
  }) {
    return DynamicContainerState(
      enableModification: enableModification ?? this.enableModification,
      borderRadius: borderRadius ?? this.borderRadius,
      colorOpacity: colorOpacity ?? this.colorOpacity,
    );
  }
}
