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
        appBar: AppBar(title: const Text('Dashboard')),
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
                    const Flexible(
                      flex: 2,
                      child: VerticalMenu(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(flex: 4, child: MenuList()),
                    const Expanded(flex: 17, child: Text('Dashboard page')),
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
