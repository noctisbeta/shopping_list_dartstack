import 'dart:io';

import 'package:common/exceptions/bad_content_type_exception.dart';
import 'package:dart_frog/dart_frog.dart';

extension RequestExtension on Request {
  /// Throws [BadContentTypeException] if the request's content type is not
  /// [mime].
  void assertContentType(String mime) =>
      headers[HttpHeaders.contentTypeHeader]?.contains(mime) ?? false
          ? true
          : throw const BadContentTypeException('Invalid content type');
}
