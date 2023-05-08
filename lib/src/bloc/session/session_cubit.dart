


import 'package:abac_challenge/src/bloc/session/session_state.dart';
import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepo authRepo;

  SessionCubit({required this.authRepo}) : super(UnkownSessionState()){
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try{
      final token = await authRepo.attemptAutoLogin();
      emit(AuthenticatedSessionState(token: token));
    } catch(e){
      emit(UnauthenticatedSessionState());
    }
  }

  void showAuth() => emit(UnauthenticatedSessionState());
  void showSession(String token) => emit(AuthenticatedSessionState(token: token));
  void signOut() async {
    await authRepo.signOut();
    emit(UnauthenticatedSessionState());
  }

}