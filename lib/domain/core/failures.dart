import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  /// Auth failures
  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = ShortPassword<T>;

  /// Note failures
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;

  const factory ValueFailure.empty() = Empty;

  const factory ValueFailure.multiLine({
    required T failedValue,
  }) = MultiLine;

  const factory ValueFailure.listTooLong({
    required T failedValue,
    required int max,
  }) = ListTooLong;
}
