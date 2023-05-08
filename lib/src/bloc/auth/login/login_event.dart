abstract class LoginEvent{}

class LoginEmailChanged extends LoginEvent{
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent{
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginPasswordVisibilityChanged extends LoginEvent{
  final bool isVisible;

  LoginPasswordVisibilityChanged({required this.isVisible});
}

class LoginSubmitted extends LoginEvent{
}