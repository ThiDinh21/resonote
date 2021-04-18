import 'package:auto_route/auto_route.dart';

import '../sign_in/sign_in_screen.dart';
import '../splash/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: SignInScreen),
  ],
  generateNavigationHelperExtension: true,
)
class $AppRouter {}
