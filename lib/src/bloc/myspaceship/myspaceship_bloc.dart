import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/myspaceship_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/spaceships_repo.dart';

class MyspaceshipBloc extends Bloc<MyspaceshipEvent, MyspaceshipState> {
  final SpaceshipsRepo spaceshipsRepo;

  MyspaceshipBloc({required this.spaceshipsRepo})
      : super(MyspaceshipState(spaceships: [])) {
    on<MyspaceshipEvent>(_onEvent);
  }

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
