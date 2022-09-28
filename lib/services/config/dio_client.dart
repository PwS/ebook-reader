import 'package:dio/dio.dart';
import 'package:ebook/services/config/dio_interceptor.dart';
import 'package:ebook/utils/constant/constant_value.dart';
import 'package:ebook/utils/utils.dart';

class DioClient {
  late Dio _dio;

  DioClient({bool isUnitTest = false, Map<String, dynamic>? headers}) {
    _dio = Dio(
      BaseOptions(
        headers: headers ??
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
        receiveTimeout: 60 * 1000, // 60 seconds,
        connectTimeout: 60 * 1000, // 60 seconds,
        validateStatus: (int? status) {
          return status! > 0;
        },
      ),
    );
    _dio.interceptors
      ..add(alice.getDioInterceptor())
      ..add(DioInterceptor());
  }

  Future<Response> getRequest(String url,
      {Map<String, dynamic>? queryParameters, bool withToken = true}) async {
    String? token = await flutterSecureStorage.read(key: ConstantValue.keyToken);
    try {
      if (withToken) {
        _dio.options.headers['Authorization'] = 'bearer $token';
      }
      return await _dio.get(url, queryParameters: queryParameters);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameter,
    bool withToken = true,
  }) async {
    try {
      if (withToken) {
        String? token = await flutterSecureStorage.read(key: ConstantValue.keyToken);
        _dio.options.headers['authorization'] = 'bearer $token';
      }
      return await _dio.post(url, queryParameters: queryParameter, data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
