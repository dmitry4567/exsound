part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginAuth extends LoginEvent {
  final String email;
  final String password;

  const LoginAuth(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
