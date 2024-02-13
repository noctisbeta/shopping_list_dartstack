import 'package:common/abstractions/json_mappable.dart';
import 'package:common/exceptions/request_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CheckItemRequest extends Equatable implements MapSerializable {
  const CheckItemRequest({
    required this.checked,
  });

  final bool checked;

  @override
  Map<String, dynamic> toMap() => {
        'checked': checked,
      };

  static CheckItemRequest validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'checked': final bool checked,
        } =>
          CheckItemRequest(checked: checked),
        _ => throw const BadRequestBodyException(
            'Invalid map format for CheckItemRequest',
          )
      };

  @override
  List<Object?> get props => [checked];

  @override
  bool get stringify => true;
}
