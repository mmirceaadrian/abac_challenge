import '../../form_state.dart';

class RegisterState{
  // email
  final String email;
  bool get isValidEmail => RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  // password 
  final String password;
  bool get isValidPassword => password.length >= 6;
  final String passwordVerification;
  bool get isValidPasswordVerification => passwordVerification == password;
  final bool isPasswordVisible;

  // form
  final FormStatus formStatus;

  RegisterState({
    this.email = '',
    this.password = '',
    this.passwordVerification = '',
    this.isPasswordVisible = false,
    this.formStatus = const FormInitial()
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? passwordVerification,
    bool? isPasswordVisible,
    FormStatus? formStatus
  }){
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordVerification: passwordVerification ?? this.passwordVerification,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formStatus: formStatus ?? this.formStatus
    );
  }
}