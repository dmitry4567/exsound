import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:exstudio/main.dart';
import 'package:scope_function/scope_function.dart';
import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;

final dioClient = Dio(
  BaseOptions(
    baseUrl: "https://935a-87-117-52-6.ngrok-free.app/api",
    connectTimeout: 30000,
    receiveTimeout: 3000,
  ),
).also((it) {
  it.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Add the access token to the request header
      options.headers['Content-Type'] = 'application/json';
      options.headers['apikey'] =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNjkzNjg4NDAwLAogICJleHAiOiAxODUxNTQxMjAwCn0.Iy7uOckXLaFw7E0bXh94utCBkhj4irI07XUpJY3ZXK4';

      return handler.next(options);
    },
    onResponse: (e, handler) async {
      if (e.data["status"] == 401) {
        // If a 401 response is received, refresh the access token
        await ApiManager.refresh(it);

        // Update the request header with the new access token
        Map<String, dynamic> temp = jsonDecode(e.requestOptions.data);
        temp['token'] = ffAppState.userAuthToken;
        e.requestOptions.data = temp;

        // Repeat the request with the updated header
        return handler.resolve(await it.fetch(e.requestOptions));
      }

      return handler.next(e);
    },
  ));
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
      apiPath: '/auth/signIn',
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

class GetAllProject {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    // final body = '''
    // {
    //   "token": "$token"
    // }''';
    final body = '''
    {
      "start_id": 0
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/project/all',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class LikeProject {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
  }) {
    final body = '''
    {
      "token": "$token",
      "projectId": $id
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/like/like',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      dioClient: dioClient,
    );
  }
}

class UnLikeProject {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? id,
  }) {
    final body = '''
    {
      "token": "$token",
      "projectId": $id
    }''';

    return ApiManager.instance.makeApiCall(
      apiPath: '/like/unlike',
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
