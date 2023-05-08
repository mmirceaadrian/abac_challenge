import 'package:abac_challenge/src/bloc/auth/cubit/auth_cubit.dart';
import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../form_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit}) : super(LoginState()){
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    // email changed
    if(event is LoginEmailChanged){
      emit(state.copyWith(email: event.email));
    // password changed
    }else if(event is LoginPasswordChanged){
      emit(state.copyWith(password: event.password));
    // password visibility changed
    }else if(event is LoginPasswordVisibilityChanged){
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    // login submitted
    }else if(event is LoginSubmitted){
      emit(state.copyWith(formStatus: const FormSubmitting()));
      try{
        final token = await authRepo.login(state.email, state.password);
        emit(state.copyWith(formStatus: const FormSuccess()));
        emit(state.copyWith(formStatus: const FormInitial()));
        authCubit.showSession(token);
      }catch(e){
        emit(state.copyWith(
            formStatus: FormFailure(
                error: e.toString().replaceAll("Exception: ", ""))));
        emit(state.copyWith(formStatus: const FormInitial()));
      }
    }
  }
}