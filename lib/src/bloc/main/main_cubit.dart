import 'package:abac_challenge/src/bloc/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for the main screen
///
/// This cubit is used to manage the state of the main screen
class MainCubit extends Cubit<MainState> {
  MainCubit() : super(SpaceshipsState());

  void showSpaceships() => emit(SpaceshipsState());
  void showAppointments() => emit(AppointmentsState());
  void showDiagnoseStespper() => emit(DiagnoseStepperState());

  /// This method is used to show the screen by index
  ///
  /// 0 -> Spaceships
  /// 1 -> Appointments
  void showByIndex(index) {
    switch (index) {
      case 0:
        showSpaceships();
        break;
      case 1:
        showAppointments();
        break;
      default:
        showSpaceships();
    }
  }
}
