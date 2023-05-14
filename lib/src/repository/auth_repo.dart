abstract class AuthRepo {
  Future<String> attemptAutoLogin();
  Future<String> login(String email, String password);
  Future<Map<String, dynamic>> register(String email, String password);
  Future<void> signOut();
}
