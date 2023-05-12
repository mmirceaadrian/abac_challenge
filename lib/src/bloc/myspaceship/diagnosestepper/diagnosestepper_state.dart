import 'package:abac_challenge/src/models/appointment_cell.dart';
import 'package:abac_challenge/src/models/spaceship_component_model.dart';
import 'package:abac_challenge/src/models/spaceship_model.dart';

class DiagnoseStepperState {
  Spaceship? selectedSpaceship;
  List<SpaceshipComponent> selectedComponents;
  List<SpaceshipComponent> searchedComponents;

  List<AppointmentCell> appointmentCells = [];
  DateTime? selectedDate;

  int currentStepperIndex = 0;

  String? returnButtonText;
  String? nextButtonText;
  final int maxSteps = 2;

  String? error;

  DiagnoseStepperState(
      {this.selectedSpaceship,
      this.selectedComponents = const [],
      this.searchedComponents = const [],
      this.appointmentCells = const [],
      this.error = '',
      this.currentStepperIndex = 0,
      this.returnButtonText = 'INAPOI',
      this.nextButtonText = 'INAINTE',
      this.selectedDate});

  DiagnoseStepperState copyWith({
    Spaceship? selectedSpaceship,
    List<SpaceshipComponent>? selectedComponents,
    List<SpaceshipComponent>? searchedComponents,
    List<AppointmentCell>? appointmentCells,
    String? error,
    int? currentStepperIndex,
    String? returnButtonText,
    String? nextButtonText,
    DateTime? selectedDate,
  }) {
    return DiagnoseStepperState(
        selectedSpaceship: selectedSpaceship ?? this.selectedSpaceship,
        selectedComponents: selectedComponents ?? this.selectedComponents,
        searchedComponents: searchedComponents ?? this.searchedComponents,
        appointmentCells: appointmentCells ?? this.appointmentCells,
        error: error ?? this.error,
        currentStepperIndex: currentStepperIndex ?? this.currentStepperIndex,
        returnButtonText: returnButtonText ?? this.returnButtonText,
        nextButtonText: nextButtonText ?? this.nextButtonText,
        selectedDate: selectedDate ?? this.selectedDate);
  }
}
