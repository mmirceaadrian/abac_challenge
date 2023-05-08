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
