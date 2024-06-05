part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterPass extends RegisterState {
  const RegisterPass();
}

final class RegisterError extends RegisterState {
  final String error;

  const RegisterError(this.error);

  @override
  List<Object> get props => [error];
}
