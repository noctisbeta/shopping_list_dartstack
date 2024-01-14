import 'package:dio/dio.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8080',
    // baseUrl: 'https://shopping-list-backend-ca1w.onrender.com',
  ),
);
