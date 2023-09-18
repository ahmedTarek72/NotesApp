import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';

import '../forgot_password/forgot_password_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';
import '../onboarding/view/onboarding_view.dart';
import '../register/register_view.dart';
import '../splash/splash_view.dart';
import '../store_details/store_details.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashView(),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginView(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RegisterView(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ForgotPasswordView(),
        );
      case Routes.onBoardingRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const OnBoardingView(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MainView(),
          settings: settings,
        );
      case Routes.storeDetailsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const StoreDetailsView(),
          settings: settings,
        );
      default:
        return unDefinedView();
    }
  }

  static Route unDefinedView() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(" No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found "),
        ),
      ),
    );
  }
}
