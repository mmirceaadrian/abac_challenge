import 'package:abac_challenge/src/bloc/form_state.dart';

class LoginState {
  // Email
  final String email;
  bool get isValidEmail =>
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  // Password
  final String password;
  bool get isValidPassword => password.length >= 6;
  final bool isPasswordVisible;

  // Form
  final FormStatus formStatus;

  LoginState(
      {this.email = '',
      this.password = '',
      this.isPasswordVisible = false,
      this.formStatus = const FormInitial()});

  LoginState copyWith(
      {String? email,
      String? password,
      bool? isPasswordVisible,
      FormStatus? formStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        formStatus: formStatus ?? this.formStatus);
  }
}
