import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/spaceships_repo.dart';

/// Bloc for the myspaceship screen
///
/// This bloc is used to manage the state of the myspaceship screen
class MyspaceshipBloc extends Bloc<MyspaceshipEvent, MyspaceshipState> {
  /// Repository for the spaceships
  final SpaceshipsRepo spaceshipsRepo;

  MyspaceshipBloc({required this.spaceshipsRepo})
      : super(MyspaceshipState(spaceships: [])) {
    on<MyspaceshipEvent>(_onEvent);
  }

  /// This method is used to manage the events of the bloc
  Future<void> _onEvent(
      MyspaceshipEvent event, Emitter<MyspaceshipState> emit) async {
    if (event is MyspaceshipEventLoading) {
      emit(state.copyWith(spaceships: [], isLoading: true));
      try {
        var spaceships = await spaceshipsRepo.getSpaceships();
        emit(state.copyWith(spaceships: spaceships, isLoading: false));
      } catch (e) {
        emit(state.copyWith(spaceships: [], isLoading: false));
      }
    }
  }
}
