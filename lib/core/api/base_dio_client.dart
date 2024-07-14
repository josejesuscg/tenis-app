// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// import '../error/exception.dart';

// abstract class BaseDioClient {
//   late Dio _instance;

//   Future<String> getToken();

//   Future<Dio> getDio() async {

//     final token = await _getToken();
//     final tokenChecked = await checkToken(token);

//     _instance = Dio();

//     _instance.options.receiveDataWhenStatusError = true;

//     _instance.options.headers = {
//       if (token.isNotEmpty) HttpHeaders.authorizationHeader: 'Cuy-oauthtoken $tokenChecked',
//       HttpHeaders.contentTypeHeader: "application/json",
//     };

//     if (kDebugMode) _instance.interceptors.add(LogInterceptor());

//     return _instance;
//   }

//   Future<String> checkToken(String token) async {
//     return _getToken();
//   }

//   Future<String> _getToken() async {
//     final token = await getToken();

//     return token;
//   }

//   Future<Response> get(String url, {Map<String, String>? headers}) async {
//     await getDio();
//     return _processResponse(
//         () => _instance.get(url, queryParameters: headers));
//   }

//   Future<Response> getUri(url) async {
//     await getDio();
//     return _processResponse(() => _instance.getUri(url));
//   }

//   Future<Response> post(
//     url, {
//     Map<String, String>? queryParameters,
//     body,
//     Encoding? encoding,
//   }) async {
//     final dio = await getDio();


//     return _processResponse(
//         () => dio.post(url, data: body, queryParameters: queryParameters));
//   }


//   Future<Response> _processResponse(DioAction action) async {
//     try {

//       final response = await action();
//       return response;
//     } catch (e) {
//       if (e is DioError) {
//         if (e.type == DioErrorType.response) {
//           final response = e.response;
//           final statusCode = response?.statusCode;


//           switch (statusCode) {
//             case 400:
//               throw BadRequestException(json.encode(response?.data));
//             case 401:
//             case 403:
//               throw UnauthorisedException(json.encode(response?.data));
//             default:
//               throw ServerException(
//                   'Error occured while Communication with Server with StatusCode : $statusCode');
//           }
//         } else {
//           throw ServerException(
//               'Error occured while Communication with Server');
//         }
//       } else {
//         throw ServerException('Error occured while Communication with Server');
//       }
//     }
//   }
// }

// typedef DioAction = Future<Response> Function();


