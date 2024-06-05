part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterAuth extends RegisterEvent {
  final String nickname;
  final String email;
  final String telegram;
  final String password;

  const RegisterAuth(this.nickname, this.email, this.telegram, this.password);

  @override
  List<Object> get props => [nickname, email, telegram, password];
}
