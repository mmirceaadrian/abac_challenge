import 'package:abac_challenge/src/bloc/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(SpaceshipsState());

  void showSpaceships() => emit(SpaceshipsState());
  void showAppointments() => emit(AppointmentsState());

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
