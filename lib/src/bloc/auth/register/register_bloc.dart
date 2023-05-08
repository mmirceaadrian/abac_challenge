

import 'package:abac_challenge/src/bloc/auth/register/register_event.dart';
import 'package:abac_challenge/src/bloc/auth/register/register_state.dart';
import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../form_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo authRepo;

  RegisterBloc({required this.authRepo}) : super(RegisterState()){
    on<RegisterEvent>(_onEvent);
  }

  Future<void> _onEvent(RegisterEvent event, Emitter<RegisterState> emit) async {
    // email changed
    if(event is RegisterEmailChanged){
      emit(state.copyWith(email: event.email));
    // password changed
    }else if(event is RegisterPasswordChanged){
      emit(state.copyWith(password: event.password));
    // password verification changed
    }else if(event is RegisterPasswordVerificationChanged){
      emit(state.copyWith(passwordVerification: event.passwordVerification));
    // password visibility changed
    }else if(event is RegisterPasswordVisibilityChanged){
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    // register submitted
    }else if(event is RegisterSubmitted){
      emit(state.copyWith(formStatus: const FormSubmitting()));
      try{
        await authRepo.register(state.email, state.password);
        emit(state.copyWith(formStatus: const FormSuccess()));
        emit(state.copyWith(formStatus: const FormInitial()));
      }catch(e){
        emit(state.copyWith(
            formStatus: FormFailure(
                error: e.toString().replaceAll("Exception: ", ""))));
        emit(state.copyWith(formStatus: const FormInitial()));
      }
    }
  }

}