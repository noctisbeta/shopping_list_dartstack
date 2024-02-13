import 'package:common/abstractions/json_mappable.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

@immutable
final class DioWrapper {
  const DioWrapper(this.dio);

  final Dio dio;

  Future<Response<T>> get<T>(
    String path, {
    MapSerializable? queryParameters,
  }) async =>
      dio.get<T>(path, queryParameters: queryParameters?.toMap());

  Future<Response<T>> post<T>(
    String path, {
    MapSerializable? data,
  }) async =>
      dio.post<T>(
        path,
        data: data?.toMap(),
        options: Options(contentType: Headers.jsonContentType),
      );
}
