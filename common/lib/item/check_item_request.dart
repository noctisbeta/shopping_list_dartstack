import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CheckItemRequest extends Equatable {
  const CheckItemRequest({
    required this.checked,
  });

  factory CheckItemRequest._fromMap(Map<String, dynamic> map) =>
      CheckItemRequest(
        checked: map['checked'] as bool,
      );

  final bool checked;

  Map<String, dynamic> toMap() => {
        'checked': checked,
      };

  static CheckItemRequest? validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'checked': final bool _,
        } =>
          CheckItemRequest._fromMap(map),
        _ => null,
      };

  @override
  List<Object?> get props => [checked];

  @override
  bool get stringify => true;
}
