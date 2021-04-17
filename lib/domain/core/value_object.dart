import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import 'errors.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throw [UnexpectedValueError] containing the [ValueFailure]
  T? getOrCrash() {
    value.fold(
      (failure) => throw UnexpectedValueError(failure),
      (r) => r,
    );
  }

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value($value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
