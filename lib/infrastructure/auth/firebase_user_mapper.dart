import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/auth/app_user.dart';
import '../../domain/core/value_object.dart';

extension FirebaseUserDomainX on User {
  AppUser toDomain() {
    return AppUser(id: UniqueID.fromUniqueString(uid));
  }
}
