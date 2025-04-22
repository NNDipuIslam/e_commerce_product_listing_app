import 'package:dio/dio.dart';
import 'package:e_commerce_product_listing_app/core/errors/failure.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = 'https://dummyjson.com/';
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
  try {
    return await _dio.get(
      path,
      queryParameters: queryParams,
      options: Options(
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 5),
        // You can also include headers here if needed
      ),
    );
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw const OfflineFailure('Request timed out. Please check your connection.');
    } else if (e.type == DioExceptionType.connectionError ||
               e.type == DioExceptionType.unknown) {
      throw const OfflineFailure('You are offline or unable to reach the server.');
    } else {
      throw ServerFailure(e.message ?? 'Something went wrong');
    }
  } catch (e) {
    throw const ServerFailure('Unexpected error occurred.');
  }
}

}
