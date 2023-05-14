import 'package:abac_challenge/src/bloc/session/session_state.dart';
import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:abac_challenge/src/repository/production/auth_repo_prod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for the session
///
/// This cubit is used to manage the state of the session
class SessionCubit extends Cubit<SessionState> {
  /// Repository for the authentication
  final AuthRepo authRepo;

  SessionCubit({required this.authRepo}) : super(UnkownSessionState()) {
    attemptAutoLogin();
  }

  /// This method is used to attempt the auto login
  void attemptAutoLogin() async {
    try {
      final token = await authRepo.attemptAutoLogin();
      emit(AuthenticatedSessionState(token: token));
    } catch (e) {
      emit(UnauthenticatedSessionState());
    }
  }

  void showAuth() => emit(UnauthenticatedSessionState());
  void showSession(String token) =>
      emit(AuthenticatedSessionState(token: token));
  void signOut() async {
    await authRepo.signOut();
    emit(UnauthenticatedSessionState());
  }
}
