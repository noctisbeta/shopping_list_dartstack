import 'package:postgres/postgres.dart';
import 'package:shopping_list_backend/common/exceptions/database_exception.dart';

extension ResultExtension on Result {
  void assertNotEmpty() {
    if (isEmpty) {
      throw const DBEemptyResult('Result is empty');
    }
  }
}
