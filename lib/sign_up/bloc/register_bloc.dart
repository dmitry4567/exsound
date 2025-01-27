import 'package:bloc/bloc.dart';
import 'package:exstudio/backend/api_requests/api_calls.dart';
import 'package:exstudio/flutter_flow/flutter_flow_util.dart';
import 'package:exstudio/main.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<RegisterAuth>((event, emit) async {
      emit(const RegisterInitial());
      ApiCallResponse register = await SignUpCall.call(
        nickname: event.nickname,
        email: event.email,
        telegram: event.telegram,
        password: event.password,
      );

      if (register.succeeded) {
        ffAppState.setUserAuthToken(
            getJsonField(register.jsonBody ?? '', r'''$.access_token'''));
        emit(const RegisterPass());
      } else {
        emit(RegisterError(
            getJsonField(register.jsonBody ?? '', r'''$.error''').toString()));
      }
    });
  }
}
