import '../../models/spaceship_model.dart';

abstract class MyspaceshipEvent {}

class MyspaceshipEventLoading extends MyspaceshipEvent {}

class MyspaceshipEventLoaded extends MyspaceshipEvent {
  final List<Spaceship> spaceships;

  MyspaceshipEventLoaded({required this.spaceships});
}

class MyspaceshipEventError extends MyspaceshipEvent {
  final String message;

  MyspaceshipEventError({required this.message});
}
