import '../../models/spaceship_model.dart';

class MyspaceshipState {
  final List<Spaceship> spaceships;
  final bool isLoading;

  MyspaceshipState({required this.spaceships, this.isLoading = false});

  MyspaceshipState copyWith({List<Spaceship>? spaceships, bool? isLoading}) {
    return MyspaceshipState(
      spaceships: spaceships ?? this.spaceships,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
