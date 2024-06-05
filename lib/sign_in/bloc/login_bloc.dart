import 'package:bloc/bloc.dart';
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/main.dart';
import 'package:equatable/equatable.dart';
import '../../flutter_flow/custom_functions.dart' as functions;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginAuth>((event, emit) async {
      emit(const LoginInitial());
      ApiCallResponse login = await SignInCall.call(
        email: event.email,
        password: event.password,
      );

      if (functions.resultCodeSuccess(getJsonField(
        (login.jsonBody ?? ''),
        r'''$.status''',
      ))) {
        ffAppState.userAuthToken =
            getJsonField(login.jsonBody ?? '', r'''$.access_token''');
        emit(const LoginPass());
      } else {
        emit(LoginError(
            getJsonField(login.jsonBody ?? '', r'''$.error''').toString()));
      }
    });
  }
}
