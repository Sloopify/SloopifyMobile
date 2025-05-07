import 'dart:io';

abstract class BaseApiService {
  Future<dynamic> getRequest({required String url});
  Future<dynamic> postRequest(
      {required String url, required Map<String, dynamic> jsonBody,    Map<String, dynamic>? headers,
      });

  Future<dynamic> multipartRequest({
    required String url,
    required Map<String, dynamic> jsonBody,
    Map<String, dynamic>? headers,
    bool saveCookies=false,
    String? cookieName,
    String? filesAttributeName,
    List<File>? files,
  });
  Future<dynamic> deleteRequest({
    required String url,
  });
}
