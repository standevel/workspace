import 'package:flutter/material.dart';
import 'package:peersync/pages/desktop/home.page.dart';
import 'package:peersync/pages/mobile/company_logo.page.dart';
import 'package:peersync/pages/mobile/individual_signup.page.dart';
import 'package:peersync/pages/mobile/login.page.dart';
import 'package:peersync/pages/mobile/not_found.page.dart';
import 'package:peersync/pages/mobile/workspace.page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const IndividualSignUpPage());
      case '/logo':
        return MaterialPageRoute(builder: (_) => const CompanyLogoPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/create-workspace':
        return MaterialPageRoute(builder: (_) => const CreateWorkspacePage());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
