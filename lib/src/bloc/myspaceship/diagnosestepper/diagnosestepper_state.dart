import 'package:abac_challenge/src/models/appointment_cell.dart';
import 'package:abac_challenge/src/models/spaceship_component_model.dart';

class DiagnoseStepperState {
  List<SpaceshipComponent> selectedComponents;
  List<SpaceshipComponent> searchedComponents;
  List<AppointmentCell> appointmentCells = [];
  int currentStepperIndex = 0;
  String? error;
  String? returnButtonText;
  String? nextButtonText;
  final int maxSteps = 2;

  DiagnoseStepperState({
    this.selectedComponents = const [],
    this.searchedComponents = const [],
    this.appointmentCells = const [],
    this.error = '',
    this.currentStepperIndex = 0,
    this.returnButtonText = 'INAPOI',
    this.nextButtonText = 'INAINTE',
  });

  DiagnoseStepperState copyWith({
    List<SpaceshipComponent>? selectedComponents,
    List<SpaceshipComponent>? searchedComponents,
    List<AppointmentCell>? appointmentCells,
    String? error,
    int? currentStepperIndex,
    String? returnButtonText,
    String? nextButtonText,
  }) {
    return DiagnoseStepperState(
        selectedComponents: selectedComponents ?? this.selectedComponents,
        searchedComponents: searchedComponents ?? this.searchedComponents,
        appointmentCells: appointmentCells ?? this.appointmentCells,
        error: error ?? this.error,
        currentStepperIndex: currentStepperIndex ?? this.currentStepperIndex,
        returnButtonText: returnButtonText ?? this.returnButtonText,
        nextButtonText: nextButtonText ?? this.nextButtonText);
  }
}
