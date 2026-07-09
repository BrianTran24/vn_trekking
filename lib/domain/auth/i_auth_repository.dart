abstract class IAuthRepository {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> loginWithGoogle();
  Future<void> loginWithApple();
  Future<void> logout();
}
