import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exstudio/account/model/account_model.dart';
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountEvent>((event, emit) async {
      emit(AccountGettingData());

      ApiCallResponse data = await GetAccountInfo.call(
        token: FFAppState().userAuthToken,
      );

      if (data.succeeded) {
        emit(AccountDataPass(Account.fromJson(data.jsonBody)));
      } else {
        emit(AccountError("error"));
      }
    });
  }
}
