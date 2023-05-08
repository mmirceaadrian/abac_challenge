abstract class SessionState{}

class UnkownSessionState extends SessionState{}

class AuthenticatedSessionState extends SessionState{
  final String token;

  AuthenticatedSessionState({required this.token});
}

class UnauthenticatedSessionState extends SessionState{}

