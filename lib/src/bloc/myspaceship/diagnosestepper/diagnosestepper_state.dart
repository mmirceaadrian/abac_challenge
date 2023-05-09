import 'package:abac_challenge/src/models/spaceship_component_model.dart';

class DiagnoseStepperState {
  List<SpaceshipComponent> selectedComponents;
  List<SpaceshipComponent> searchedComponents;
  String? error;

  DiagnoseStepperState({
    this.selectedComponents = const [],
    this.searchedComponents = const [],
    this.error = '',
  });

  DiagnoseStepperState copyWith({
    List<SpaceshipComponent>? selectedComponents,
    List<SpaceshipComponent>? searchedComponents,
    String? error,
  }) {
    return DiagnoseStepperState(
        selectedComponents: selectedComponents ?? this.selectedComponents,
        searchedComponents: searchedComponents ?? this.searchedComponents,
        error: error ?? this.error);
  }
}
