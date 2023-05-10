import 'package:abac_challenge/src/models/spaceship_component_model.dart';

abstract class DiagnoseStepperEvent {}

class DiagnoseStepperSearch extends DiagnoseStepperEvent {
  final String query;

  DiagnoseStepperSearch({required this.query});
}

class DiagnoseStepperAddComponent extends DiagnoseStepperEvent {
  final SpaceshipComponent spaceshipComponent;
  final int quantity;

  DiagnoseStepperAddComponent(
      {required this.spaceshipComponent, this.quantity = 1});
}

class DiagnoseStepperRemoveComponent extends DiagnoseStepperEvent {
  final SpaceshipComponent spaceshipComponent;

  DiagnoseStepperRemoveComponent({required this.spaceshipComponent});
}

class DiagnoseStepperNextStep extends DiagnoseStepperEvent {}

class DiagnoseStepperPreviousStep extends DiagnoseStepperEvent {}
