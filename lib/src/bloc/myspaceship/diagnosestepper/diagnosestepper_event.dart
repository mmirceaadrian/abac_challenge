import 'package:abac_challenge/src/models/service_model.dart';
import 'package:abac_challenge/src/models/spaceship_component_model.dart';
import 'package:abac_challenge/src/models/spaceship_model.dart';

abstract class DiagnoseStepperEvent {}

class DiagnoseStepperSearchComponent extends DiagnoseStepperEvent {
  final String query;

  DiagnoseStepperSearchComponent({required this.query});
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

class DiagnoseStepperGetAppointmentCells extends DiagnoseStepperEvent {
  final DateTime startDate;
  final DateTime endDate;

  DiagnoseStepperGetAppointmentCells(
      {required this.startDate, required this.endDate});
}

class DiagnoseStepperSelectDate extends DiagnoseStepperEvent {
  final DateTime date;

  DiagnoseStepperSelectDate({required this.date});
}

class DiagnoseStepperInitialize extends DiagnoseStepperEvent {
  final Spaceship spaceship;

  DiagnoseStepperInitialize({required this.spaceship});
}

class DiagnoseStepperSortByPrice extends DiagnoseStepperEvent {
  final bool value;

  DiagnoseStepperSortByPrice({required this.value});
}

class DiagnoseStepperSortByRating extends DiagnoseStepperEvent {
  final bool value;

  DiagnoseStepperSortByRating({required this.value});
}

class DiagnoseStepperSortByTime extends DiagnoseStepperEvent {
  final bool value;

  DiagnoseStepperSortByTime({required this.value});
}

class DiagnoseStepperSearchService extends DiagnoseStepperEvent {
  final String query;

  DiagnoseStepperSearchService({required this.query});
}

// event for filtering the services
class DiagnoseStepperFilter extends DiagnoseStepperEvent {}

class DiagnoseStepperSelectService extends DiagnoseStepperEvent {
  final ServiceModel service;

  DiagnoseStepperSelectService({required this.service});
}

class DiagnoseStepperSendAppointment extends DiagnoseStepperEvent {}
