part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  final String error;

  const LoginState({
    required this.email,
    required this.password,
    required this.isLoading,
    required this.isSuccess,
    required this.error,
  });

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        isLoading: false,
        isSuccess: false,
        error: '',
      );

  bool get isValid => email.contains('@') && password.length >= 6;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [email, password, isLoading, isSuccess, error];
}
