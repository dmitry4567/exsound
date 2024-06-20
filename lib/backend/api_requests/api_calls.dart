import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exstudio/app_state.dart';
import 'package:exstudio/main.dart';
import 'package:scope_function/scope_function.dart';
import '../../flutter_flow/custom_functions.dart' as f;
import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;

class CustomInterceptors extends InterceptorsWrapper {
  final Dio api;

  CustomInterceptors(this.api);

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';
    // log(handler.toString());
    return handler.next(options); // продолжаем выполнение запроса
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}]: ${response.data}');
    return handler.next(response); // продолжаем выполнение запроса
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 400) {
      try {
        var pathToFunction = '/auth/refresh';

        var result = await dioClient.post(pathToFunction,
            data: '''{"refresh_token": "${ffAppState.refreshToken}"}''');

        Map<String, dynamic> data = jsonDecode(jsonEncode(result.data));

        if (result.statusCode == 201) {
          ffAppState.setRefreshToken(data["refresh_token"]);
          ffAppState.setUserAuthToken(data["access_token"]);
        }

        _retry(err.requestOptions);
      } on DioError catch (e) {}
      return;
    }
    return handler.next(err);
  }
}

Future<Response<dynamic>> _retry(RequestOptions reqOpt) {
  final options = Options(method: reqOpt.method, headers: reqOpt.headers);

  return dioClient.request<dynamic>(
    reqOpt.path,
    queryParameters: reqOpt.queryParameters,
    options: options,
  );
}

final dioClient = Dio(
  BaseOptions(
    baseUrl: "http://192.168.0.109:3000/api",
    connectTimeout: 30000,
    receiveTimeout: 3000,
    // validateStatus: (status) {
    //   return f.resultCodeSuccess(status!);
    // },
  ),
).also((it) {
  it.interceptors.add(CustomInterceptors(it));
});

class SignInCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    final body = '''
    {
      "email": "$email",
      "password": "$password"
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/auth/login',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class SignUpCall {
  static Future<ApiCallResponse> call({
    String? nickname = '',
    String? email = '',
    String? telegram = '',
    String? password = '',
  }) {
    final body = '''
    {
      "nickname": "$nickname",
      "email": "$email", 
      "telegram": "$telegram",
      "password": "$password"
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/auth/signUp',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class GetSessionsByTimePeriod {
  static Future<ApiCallResponse> call({
    String token = '',
    int from = 0,
    int until = 0,
  }) {
    final body = '''
    {
      "token:": "$token",
      "from": $from,
      "until": $until
    }''';

    log(body);

    return ApiManager.instance.makeApiCall(
      apiPath: '/studio-sessions/findByTimePeriod',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class SubscribeNotification {
  static Future<ApiCallResponse> call({
    String token = '',
    String deviceToken = '',
  }) {
    final body = '''
    {
      "token": "$token",
      "device_token": "$deviceToken"
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/notification/subscribe',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class GetAccountInfo {
  static Future<ApiCallResponse> call({
    String token = '',
  }) {
    final body = '''
    {
      "token": "$token"
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/user/info',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}
