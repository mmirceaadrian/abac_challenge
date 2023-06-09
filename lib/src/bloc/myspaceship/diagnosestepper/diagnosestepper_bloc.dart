import 'package:abac_challenge/src/bloc/main/main_cubit.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:abac_challenge/src/models/appointmentcell_model.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc for the diagnose stepper
///
/// This bloc is used to manage the state of the diagnose stepper
class DiagnoseStepperBloc
    extends Bloc<DiagnoseStepperEvent, DiagnoseStepperState> {
  final DiagnoseRepo diagnoseRepo;
  final MainCubit mainCubit;

  DiagnoseStepperBloc({required this.diagnoseRepo, required this.mainCubit})
      : super(DiagnoseStepperState()) {
    on<DiagnoseStepperEvent>(_onEvent);
  }

  Future<void> _onEvent(
      DiagnoseStepperEvent event, Emitter<DiagnoseStepperState> emit) async {
    // Event for initializing the stepper
    if (event is DiagnoseStepperInitialize) {
      emit(state.copyWith(selectedSpaceship: event.spaceship));
    }

    // Event for searching components
    if (event is DiagnoseStepperSearchComponent) {
      try {
        if (event.query.isEmpty) {
          emit(state.copyWith(searchedComponents: []));
          return;
        }
        var components = await diagnoseRepo.searchComponent(event.query);
        emit(state.copyWith(searchedComponents: components));
      } catch (e) {
        emit(state.copyWith(searchedComponents: []));
      }
    }

    // Event for adding a component to the list of selected components
    if (event is DiagnoseStepperAddComponent) {
      var index = state.selectedComponents.indexWhere((element) =>
          element.spaceshipComponentId ==
          event.spaceshipComponent.spaceshipComponentId);

      if (index == -1) {
        event.spaceshipComponent.quantity = event.quantity;
        emit(state.copyWith(selectedComponents: [
          ...state.selectedComponents,
          event.spaceshipComponent
        ], error: ''));
      } else {
        emit(state.copyWith(error: 'Component already added'));
      }
    }

    // Event for removing a component from the list of selected components
    if (event is DiagnoseStepperRemoveComponent) {
      var index = state.selectedComponents.indexWhere((element) =>
          element.spaceshipComponentId ==
          event.spaceshipComponent.spaceshipComponentId);

      if (index != -1) {
        var selectedComponents = state.selectedComponents;
        selectedComponents.removeAt(index);
        emit(state.copyWith(selectedComponents: selectedComponents));
      }
    }

    // Event for switching to the next step
    if (event is DiagnoseStepperNextStep) {
      if (state.currentStepperIndex == state.maxSteps) {
        if (state.selectedService == null) {
          emit(state.copyWith(error: 'Please select a service'));
          return;
        }
        emit(state.copyWith(showDialog: true));
        return;
      }
      if (state.selectedComponents.isEmpty) {
        emit(state.copyWith(error: 'Please add at least one component'));
        return;
      }
      if (state.currentStepperIndex == 1 && state.selectedDate == null) {
        emit(state.copyWith(error: 'Please select a valid date'));
        return;
      }
      emit(state.copyWith(currentStepperIndex: state.currentStepperIndex + 1));
    }

    // Event for switching to the previous step
    if (event is DiagnoseStepperPreviousStep) {
      if (state.currentStepperIndex == 0) {
        mainCubit.showSpaceships();
        return;
      }
      emit(state.copyWith(currentStepperIndex: state.currentStepperIndex - 1));
    }

    // Event for getting the booked appointment cells
    if (event is DiagnoseStepperGetAppointmentCells) {
      try {
        var cells = await diagnoseRepo.getAppointmentCells(
            event.startDate, event.endDate);
        emit(state.copyWith(appointmentCells: cells));
      } catch (e) {
        emit(state.copyWith(appointmentCells: []));
      }
    }

    // Event for selecting a date
    if (event is DiagnoseStepperSelectDate) {
      emit(state.copyWith(selectedDate: event.date, error: ''));
    }

    if (event is DiagnoseStepperSortByPrice) {
      // sort by price
      emit(state.copyWith(sortByPrice: event.value));
    }

    if (event is DiagnoseStepperSortByRating) {
      // sort by rating
      emit(state.copyWith(sortByRating: event.value));
    }

    if (event is DiagnoseStepperSortByTime) {
      // sort by time
      emit(state.copyWith(sortByTime: event.value));
    }

    if (event is DiagnoseStepperFilter) {
      var sortedServices = state.searchedServices;
      if (state.sortByPrice) {
        if (state.sortByRating) {
          if (state.sortByTime) {
            sortedServices.sort((a, b) =>
                a.cost.compareTo(b.cost) &
                b.rating.compareTo(a.rating) &
                a.distance.compareTo(b.distance));
            emit(state.copyWith(sortedServices: sortedServices));
            return;
          } else {
            sortedServices.sort((a, b) =>
                a.cost.compareTo(b.cost) & b.rating.compareTo(a.rating));
            emit(state.copyWith(sortedServices: sortedServices));
            return;
          }
        }
        if (state.sortByTime) {
          sortedServices.sort((a, b) =>
              a.cost.compareTo(b.cost) & a.distance.compareTo(b.distance));
          emit(state.copyWith(sortedServices: sortedServices));
          return;
        }
        sortedServices.sort((a, b) => a.cost.compareTo(b.cost));
      }
      if (state.sortByRating) {
        if (state.sortByTime) {
          sortedServices.sort((a, b) =>
              b.rating.compareTo(a.rating) & a.distance.compareTo(b.distance));
          emit(state.copyWith(sortedServices: sortedServices));
          return;
        }
        sortedServices.sort((a, b) => b.rating.compareTo(a.rating));
      }
      if (state.sortByTime) {
        sortedServices.sort((a, b) => a.distance.compareTo(b.distance));
        emit(state.copyWith(sortedServices: sortedServices));
        return;
      }
      emit(state.copyWith(sortedServices: sortedServices));
    }

    // Event for searching services
    if (event is DiagnoseStepperSearchService) {
      try {
        var services = await diagnoseRepo.getServices(event.query);
        emit(state.copyWith(
            searchedServices: services, sortedServices: services));
      } catch (e) {
        emit(state.copyWith(searchedServices: []));
      }
    }

    // Event for selecting a service
    if (event is DiagnoseStepperSelectService) {
      emit(state.copyWith(selectedService: event.service));
    }

    // Event for sending a appointment request
    if (event is DiagnoseStepperSendAppointment) {
      try {
        diagnoseRepo.addAppointment(
            AppointmentCell(appointmentId: 0, date: state.selectedDate!));
      } catch (e) {
        emit(state.copyWith(error: 'Something went wrong'));
      }
    }
  }
}
