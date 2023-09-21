import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/widgets/vertical_menu.dart';

import '../../constants.dart';
import '../../widgets/drawer_sidebar.dart';
import '../../widgets/menu.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(),
        drawer: const sideDrawer(),
        body: FutureBuilder<String>(
            future: checkUserToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData && snapshot.data != null) {
                  return Row(children: [
                    Container(
                        constraints: const BoxConstraints(maxWidth: 100.0),
                        child: const VerticalMenu()),
                    Flexible(
                      flex: 1,
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 300.0, maxWidth: 350.0), // Minimum width
                        child: MenuList(),
                      ),
                    ),
                    const Expanded(child: Text('Dashboard page')),
                  ]);
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, '/login');
                  });
                  return const Center(
                    child: Text('Redirecting to login...'),
                  );
                }
              }
            }));
  }
}

// chat section color : F0F0F0F0