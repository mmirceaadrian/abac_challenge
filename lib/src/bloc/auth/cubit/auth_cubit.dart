import 'package:flutter_bloc/flutter_bloc.dart';

import '../../session/session_cubit.dart';

enum AuthState {login, register}

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  void showLogin() => emit(AuthState.login);
  void showRegister() => emit(AuthState.register);
  void showSession(String token) => sessionCubit.showSession(token);
}