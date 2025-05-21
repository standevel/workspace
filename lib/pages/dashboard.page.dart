import 'package:flutter/material.dart';
import 'package:peersync/pages/desktop/dashboard.page.dart';
import 'package:peersync/pages/mobile/dashboard.mobile.page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 700
        ? const TeamDashboardDesktopPage()
        : const TeamDashboardMobilePage();
  }
}
