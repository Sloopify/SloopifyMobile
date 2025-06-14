import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';
import 'package:sloopify_mobile/core/api_service/api_urls.dart';
import 'package:sloopify_mobile/core/local_storage/preferene_utils.dart';
import 'package:sloopify_mobile/core/local_storage/prefernces_key.dart';

import '../errors/dio_exceptions.dart';
import 'base_api_service.dart';

class NetworkServiceDio implements BaseApiService {
  Future<Dio> get dio async {
    // String? token = PreferenceUtils.getString("TOKEN");
    final token = PreferenceUtils.getString(SharedPrefsKey.accessToken);

    BaseOptions options = BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 100000),
        receiveTimeout: const Duration(seconds: 100000),
        headers: {
          "Content-Type": Headers.jsonContentType,
          if (token != null) 'Authorization': 'Bearer $token',
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (validate) => true
    );


    Dio dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        // Do something with response data

        return handler.next(response); // continue
      },
      onError: (e, handler) {
        print('error is $e');
        throw DioExceptions
            .handle(e)
            .failure;
      },
    ));

    return dio;
  }

  @override
  Future deleteRequest({required String url}) {
    throw UnimplementedError();
  }

  @override
  Future getRequest({required String url, Map<String, dynamic>? params,
    Map<String, dynamic> ?jsonBody,

    Map<String, dynamic>? headers,}) async {
    print('API $url');
    Dio _dio = await dio;
    print("BODY $jsonBody");
    print("Headers $headers");

    try {
      var response = await _dio.get(
          url,
          data:jsonBody,
        queryParameters: params
      );
      if (headers != null) {
        _dio.options.headers = headers;
        print('Headers${headers}');
      }
      if (response.headers.value("Authorization") != null) {
        await PreferenceUtils.setString(SharedPrefsKey.accessToken,
            response.headers.value("Authorization")!);
      }
      print('status code ${response.statusCode}');
      print('header token ${response.headers.value("Authorization")}');
      Logger().i(response.data);
      return response.data;
    } catch (error) {
      throw DioExceptions
          .handle(error)
          .failure;
    }
  }

  @override
  Future multipartRequest({
    required String url,
    required Map<String, dynamic> jsonBody,
    Map<String, dynamic>? headers,
    bool saveCookies = false,
    String? cookieName,
    String? filesAttributeName,
    List<File>? files,
  }) async {
    print('API $url');
    Logger().i(jsonBody);
    Dio _dio = await dio;
    try {
      if (filesAttributeName != null && files != null) {
        List<MultipartFile> docsFile = [];
        for (var element in files) {
          String fileName = element.path
              .split('/')
              .last;
          docsFile.add(
            await MultipartFile.fromFile(
              element.path,
              filename: fileName,
            ),
          );
        }
        await jsonBody.putIfAbsent(filesAttributeName, () => docsFile);
      }
      if (headers != null) {
        _dio.options.headers = headers;
        print('Headers${headers}');

      }
      final response = await _dio.post(
        url,
        data: jsonBody,
      );

      // //save specific cookie if the user send saveCookies as true
      // if (saveCookies) {
      //   final setCookieHeader = response.headers['Set-Cookie'];
      //   if (setCookieHeader != null) {
      //     final cookieValue = extractSpecificCookieValue(
      //         cookiesList: setCookieHeader, cookieName: cookieName!);
      //    // PreferenceUtils.setString(cookieName, cookieValue!);
      //     print('Stored value: $cookieValue');
      //   }
      // }
      if (response.headers.value("Authorization") != null) {
        await PreferenceUtils.setString(SharedPrefsKey.accessToken,
            response.headers.value("Authorization")!);
      }

      print('status code ${response.statusCode}');
      print('header token ${response.headers.value("Authorization")}');
      Logger().i(response.data);
      return response.data;
    } catch (error) {
      print('errrrrrrrrrrrrrrrrrrrrr${error}');

      throw DioExceptions
          .handle(error)
          .failure;
    }
  }

  @override
  Future postRequest({
    required String url,
    required Map<String, dynamic> jsonBody,
    Map<String, dynamic>? headers,

  }) async {
    print('API $url');
    try {
      Dio _dio = await dio;
      print('body: $jsonBody');
      print('headers ${headers}');
      if (headers != null) {
        _dio.options.headers = headers;
      }
      var response = await _dio.post(url, data: jsonBody);
      if (response.headers.value("Authorization") != null) {
        await PreferenceUtils.setString(SharedPrefsKey.accessToken,
            response.headers.value("Authorization")!);
      }

      print('headers response  ${response.headers}');

      return response.data;
    } catch (error) {
      if (error is DioException) {
        print(error.error.toString());
        print('Error ${error.response?.data}');
        print('status code ${error.response?.statusCode}');
      } else {
        print('errrrrrrrrrrrrrrrrrrrrr${error}');
      }

      throw DioExceptions
          .handle(error)
          .failure;
    }
  }

  String? extractSpecificCookieValue(
      {required List<String> cookiesList, required String cookieName}) {
    for (String cookie in cookiesList) {
      if (cookie.startsWith('$cookieName=')) {
        final mobileQueriesValue =
        RegExp('$cookieName=([^;]+)').firstMatch(cookie)?.group(1);
        return mobileQueriesValue;
      }
    }
    return null;
  }

  @override
  Future uploadFiles({required String url, required Map<String, dynamic> jsonBody, Map<String, dynamic>? headers}) async {
    try {
      FormData formData = FormData.fromMap(jsonBody);
      print('files : ${formData.files}');
      print('body: ${formData.fields}');
      Dio _dio = await dio;

      if (headers != null) {
        _dio.options.headers = headers;
      }
      final response = await _dio.post(
        url,
        data: formData,
      );


      print('status code ${response.statusCode}');
      print('response data ${response.data}');
      print('cookies ${response.headers['Set-Cookie']}');
      print('headers ${headers}');
      print('headers response  ${response.headers}');
      return response.data;
    } catch (error) {
      print('errrrrrrrrrrrrrrrrrrrrr${error}');

      throw DioExceptions
          .handle(error)
          .failure;
    }
  }
}
