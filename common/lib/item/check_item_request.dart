import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class CheckItemRequest extends Equatable {
  const CheckItemRequest({
    required this.id,
    required this.checked,
  });

  factory CheckItemRequest._fromMap(Map<String, dynamic> map) =>
      CheckItemRequest(
        id: map['id'] as int,
        checked: map['checked'] as bool,
      );

  final int id;
  final bool checked;

  Map<String, dynamic> toMap() => {
        'id': id,
        'checked': checked,
      };

  static CheckItemRequest? validatedFromMap(Map<String, dynamic> map) =>
      switch (map) {
        {
          'id': final int _,
          'checked': final bool _,
        } =>
          CheckItemRequest._fromMap(map),
        _ => null,
      };

  @override
  List<Object?> get props => [id, checked];

  @override
  bool get stringify => true;
}
