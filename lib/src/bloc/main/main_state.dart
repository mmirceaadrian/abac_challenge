import 'package:abac_challenge/src/models/spaceship_model.dart';

abstract class MainState {
  final int index;
  const MainState(this.index);
}

class SpaceshipsState extends MainState {
  const SpaceshipsState() : super(0);
}

class AppointmentsState extends MainState {
  const AppointmentsState() : super(1);
}

class DiagnoseState extends MainState {
  final Spaceship spaceship;
  const DiagnoseState(
    this.spaceship,
  ) : super(0);
}
