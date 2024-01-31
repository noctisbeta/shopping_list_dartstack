import 'package:common/exceptions/request_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CheckItemRequest extends Equatable {
  const CheckItemRequest._({
    required this.checked,
  });

  final bool checked;

  Map<String, dynamic> toMap() => {
        'checked': checked,
      };

  static CheckItemRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'checked': final bool checked,
        } =>
          CheckItemRequest._(checked: checked),
        _ => throw const BadRequestBodyException(
            'Invalid map format for CheckItemRequest',
          )
      };

  @override
  List<Object?> get props => [checked];

  @override
  bool get stringify => true;
}
