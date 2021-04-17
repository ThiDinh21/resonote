import 'failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encounter ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation \nFailure was: $valueFailure.');
  }
}
