part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginPass extends LoginState {
  const LoginPass();
}

final class LoginError extends LoginState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}
