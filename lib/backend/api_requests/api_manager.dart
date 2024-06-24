import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';

enum ApiCallType {
  GET,
  POST,
  DELETE,
  PUT,
  PATCH,
}

enum BodyType {
  NONE,
  JSON,
  TEXT,
  X_WWW_FORM_URL_ENCODED,
}

class ApiCallResponse {
  const ApiCallResponse(this.jsonBody, this.headers, this.statusCode);
  final dynamic jsonBody;
  final Headers headers;
  final int statusCode;
  // Whether we received a 2xx status (which generally marks success).
  bool get succeeded => statusCode >= 200 && statusCode < 300;
  String getHeader(String headerName) => headers.value(headerName) ?? '';

  static Future<ApiCallResponse> fromHttpResponse(
    Response<dynamic> response,
    bool returnBody,
  ) async {
    dynamic jsonBody;

    try {
      jsonBody = returnBody ? response.data : null;
      return ApiCallResponse(jsonBody, response.headers, response.statusCode!);
    } catch (_) {
      return ApiCallResponse(null, Headers(), 400);
    }
  }

  static ApiCallResponse fromCloudCallResponse(Map<String, dynamic> response) =>
      ApiCallResponse(
        response['body'],
        Headers.fromMap(response['headers'] ?? {}),
        response['statusCode'] ?? 400,
      );
}

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  static Map<String, String> toStringMap(Map map) =>
      map.map((key, value) => MapEntry(key.toString(), value.toString()));

  static String asQueryParams(Map<String, dynamic> map) =>
      map.entries.map((e) => "${e.key}=${e.value}").join('&');

  static Future<ApiCallResponse> urlRequest(
    ApiCallType callType,
    String pathToFunction,
    Map<String, dynamic> params,
    bool returnBody,
    Dio dioClient,
  ) async {
    if (params.isNotEmpty) {
      final lastUriPart = pathToFunction.split('/').last;
      final needsParamSpecifier = !lastUriPart.contains('?');
      pathToFunction =
          '$pathToFunction${needsParamSpecifier ? '?' : ''}${asQueryParams(params)}';
    }
    final makeRequest =
        callType == ApiCallType.GET ? dioClient.get : dioClient.delete;
    final response = await makeRequest(pathToFunction);
    return ApiCallResponse.fromHttpResponse(
      response,
      returnBody,
    );
  }

  static Future<ApiCallResponse> requestWithBody(
    ApiCallType type,
    String pathToFunction,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    String? body,
    BodyType? bodyType,
    bool returnBody,
    Dio dioClient,
  ) async {
    assert(
      {ApiCallType.POST, ApiCallType.PUT, ApiCallType.PATCH}.contains(type),
      'Invalid ApiCallType $type for request with body',
    );
    final postBody = createBody(headers, params, body, bodyType);
    try {
      final response = await dioClient.post(pathToFunction, data: postBody);
      return ApiCallResponse.fromHttpResponse(
        response,
        returnBody,
      );
    } on DioError catch (e) {
      return ApiCallResponse(
          e.response!.data!, Headers(), e.response!.statusCode!);
    }
  }

  static dynamic createBody(
    Map<String, dynamic> headers,
    Map<String, dynamic>? params,
    String? body,
    BodyType? bodyType,
  ) {
    dynamic postBody;
    switch (bodyType) {
      case BodyType.JSON:
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.TEXT:
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.X_WWW_FORM_URL_ENCODED:
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.NONE:
      case null:
        break;
    }

    return postBody;
  }

  Future<ApiCallResponse> makeApiCall({
    required String apiPath,
    required ApiCallType callType,
    required Dio dioClient,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
  }) async {
    ApiCallResponse result;
    switch (callType) {
      case ApiCallType.GET:
      case ApiCallType.DELETE:
        result = await urlRequest(
          callType,
          apiPath,
          params,
          returnBody,
          dioClient,
        );
        break;
      case ApiCallType.POST:
      case ApiCallType.PUT:
      case ApiCallType.PATCH:
        result = await requestWithBody(
          callType,
          apiPath,
          headers,
          params,
          body,
          bodyType,
          returnBody,
          dioClient,
        );
        break;
    }

    return result;
  }
}
