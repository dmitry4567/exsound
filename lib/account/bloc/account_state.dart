part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {
  const AccountInitial();
}

final class AccountGettingData extends AccountState {
  const AccountGettingData();
}

final class AccountDataPass extends AccountState {
  final Account data;

  const AccountDataPass(this.data);

  @override
  List<Object> get props => [data];
}

final class AccountError extends AccountState {
  final String error;

  const AccountError(this.error);

  @override
  List<Object> get props => [error];
}
