import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:abac_challenge/src/models/service_model.dart';
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

  bool sortByPrice;
  bool sortByRating;
  bool sortByTime;
  List<ServiceModel> searchedServices;
  List<ServiceModel> sortedServices; // remove this when backend is ready
  ServiceModel? selectedService;

  bool showDialog;

  DiagnoseStepperState({
    this.selectedSpaceship,
    this.selectedComponents = const [],
    this.searchedComponents = const [],
    this.appointmentCells = const [],
    this.error = '',
    this.currentStepperIndex = 0,
    this.returnButtonText = 'INAPOI',
    this.nextButtonText = 'INAINTE',
    this.selectedDate,
    this.sortByPrice = false,
    this.sortByRating = false,
    this.sortByTime = false,
    this.searchedServices = const [],
    this.selectedService,
    this.sortedServices = const [],
    this.showDialog = false,
  });

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
    bool? sortByPrice,
    bool? sortByRating,
    bool? sortByTime,
    List<ServiceModel>? searchedServices,
    ServiceModel? selectedService,
    List<ServiceModel>? sortedServices,
    bool? showDialog,
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
      selectedDate: selectedDate ?? this.selectedDate,
      sortByPrice: sortByPrice ?? this.sortByPrice,
      sortByRating: sortByRating ?? this.sortByRating,
      sortByTime: sortByTime ?? this.sortByTime,
      searchedServices: searchedServices ?? this.searchedServices,
      selectedService: selectedService ?? this.selectedService,
      sortedServices: sortedServices ?? this.sortedServices,
      showDialog: showDialog ?? this.showDialog,
    );
  }
}
