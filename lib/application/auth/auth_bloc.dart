import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/auth/i_auth_repository.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class GoogleLoginRequested extends AuthEvent {}

class AppleLoginRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

// State
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<AppleLoginRequested>(_onAppleLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.loginWithEmailAndPassword(event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(const AuthError('Đăng nhập thất bại. Vui lòng thử lại.'));
    }
  }

  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.loginWithGoogle();
      emit(Authenticated());
    } catch (e) {
      emit(const AuthError('Đăng nhập bằng Google thất bại.'));
    }
  }

  Future<void> _onAppleLoginRequested(
    AppleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.loginWithApple();
      emit(Authenticated());
    } catch (e) {
      emit(const AuthError('Đăng nhập bằng Apple thất bại.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(Unauthenticated());
  }
}
