import '../../domain/auth/i_auth_repository.dart';

class MockAuthRepository implements IAuthRepository {
  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock success
  }

  @override
  Future<void> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock success
  }

  @override
  Future<void> loginWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock success
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
