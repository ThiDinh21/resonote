import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/value_object.dart';

part 'app_user.freezed.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required UniqueID id,
  }) = _AppUser;
}
