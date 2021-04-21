import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'errors.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throw [UnexpectedValueError] containing the [ValueFailure]
  T? getOrCrash() {
    return value.fold(
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

class UniqueID extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueID() {
    // ignore: prefer_const_constructors
    return UniqueID._(Right(Uuid().v1()));
  }

  factory UniqueID.fromUniqueString(String uid) {
    return UniqueID._(right(uid));
  }

  const UniqueID._(this.value);
}
