import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:abac_challenge/src/repository/diagnose_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiagnoseStepperBloc
    extends Bloc<DiagnoseStepperEvent, DiagnoseStepperState> {
  final DiagnoseRepo diagnoseRepo;

  DiagnoseStepperBloc({required this.diagnoseRepo})
      : super(DiagnoseStepperState()) {
    on<DiagnoseStepperEvent>(_onEvent);
  }

  Future<void> _onEvent(
      DiagnoseStepperEvent event, Emitter<DiagnoseStepperState> emit) async {
    if (event is DiagnoseStepperSearch) {
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
  }
}
