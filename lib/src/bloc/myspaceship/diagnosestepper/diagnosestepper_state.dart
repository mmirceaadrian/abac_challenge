import 'package:abac_challenge/src/models/spaceship_component_model.dart';

class DiagnoseStepperState {
  List<SpaceshipComponent> selectedComponents;
  List<SpaceshipComponent> searchedComponents;

  DiagnoseStepperState({
    this.selectedComponents = const [],
    this.searchedComponents = const [],
  });

  DiagnoseStepperState copyWith({
    List<SpaceshipComponent>? selectedComponents,
    List<SpaceshipComponent>? searchedComponents,
  }) {
    return DiagnoseStepperState(
      selectedComponents: selectedComponents ?? this.selectedComponents,
      searchedComponents: searchedComponents ?? this.searchedComponents,
    );
  }
}
