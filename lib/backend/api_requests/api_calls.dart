import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:exstudio/main.dart';
import 'package:scope_function/scope_function.dart';
import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;

class CustomInterceptors extends InterceptorsWrapper {
  final Dio api;

  CustomInterceptors(this.api);

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';

    return handler.next(options);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 400) {
      try {
        var pathToFunction = '/auth/refresh';

        var result = await dioClient.post(pathToFunction,
            data: '''{"refresh_token": "${ffAppState.refreshToken}"}''');

        Map<String, dynamic> data = jsonDecode(jsonEncode(result.data));

        if (result.statusCode == 201) {
          ffAppState.setRefreshToken(data["refresh_token"]);
          ffAppState.setUserAuthToken(data["access_token"]);
        }

        await _getRetryRequest(err);
      } catch (e) {}
    }
    return handler.next(err);
  }

  Future<Response> _getRetryRequest(DioError err) async {
    final requestOptions = err.response!.requestOptions;

    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final dioRefresh = Dio(
      BaseOptions(
        baseUrl: requestOptions.baseUrl,
        headers: <String, String>{'Content-Type': 'application/json'},
      ),
    );

    dioRefresh.interceptors.add(this);

    final response = await dioRefresh.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );

    return response;
  }
}

final dioClient = Dio(
  BaseOptions(
    baseUrl: "http://172.20.10.5:3000/api",
    connectTimeout: 30000,
    receiveTimeout: 3000,
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
      "fullname": "впкшлвкп",
      "email": "$email", 
      "telegram": "$telegram",
      "password": "$password"
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/auth/register',
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
      "token": "$token",
      "from": $from,
      "until": $until
    }''';

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

class GetAdmins {
  static Future<ApiCallResponse> call({
    String token = '',
  }) {
    final body = '''
    {
      "token": "$token"
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/user/admins',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class CreateSession {
  static Future<ApiCallResponse> call({
    String token = '',
    int type = 0,
    String name = '',
    int to = 0,
    int until = 0,
  }) {
    final body = '''
    {
       "token": "${token}",
       "type_of_activity_id": ${type},
       "name_track": "${name}",
       "from": ${to},
       "until": ${until},
       "user_admins_id": [
         1
       ]
    }''';

    log(body);

    return ApiManager.instance.makeApiCall(
      apiPath: '/studio-sessions/create',
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
