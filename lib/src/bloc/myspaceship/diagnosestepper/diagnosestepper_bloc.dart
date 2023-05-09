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
        var components = await diagnoseRepo.searchComponent(event.query);
        emit(state.copyWith(searchedComponents: components));
      } catch (e) {
        emit(state.copyWith(searchedComponents: []));
      }
    }
    if (event is DiagnoseStepperAddComponent) {
      // check if component is already in list
      // else pop error
      var index = state.selectedComponents.indexWhere((element) =>
          element.spaceshipComponentId ==
          event.spaceshipComponent.spaceshipComponentId);

      if (index == -1) {
        emit(state.copyWith(selectedComponents: [
          ...state.selectedComponents,
          event.spaceshipComponent
        ], error: ''));
      } else {
        emit(state.copyWith(error: 'Component already added'));
      }
    }
  }
}
