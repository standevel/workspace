import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/providers/provider.dart';
import 'package:peersync/widgets/horizontal_menu.dart';
import 'package:peersync/widgets/vertical_menu.dart';
import '../../widgets/channel.dart';
import '../../widgets/drawer_sidebar.dart';
import '../../widgets/menu.dart';

class TeamDashboardMobilePage extends HookConsumerWidget {
  const TeamDashboardMobilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspacesAsyncValue = ref.watch(workspacesProvider);
    return Scaffold(
      appBar: AppBar(),
      drawer: const sideDrawer(),
      body: workspacesAsyncValue.when(
        data: (workspaces) {
          // Data is available, you can render it on the UI

          return Expanded(child: ChannelWidget());
        },
        loading: () {
          // Loading state, you can show a loading indicator
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        },
        error: (error, stackTrace) {
          // Error state, you can show an error message
          return Center(
              child: Text('Error: $error',
                  style: const TextStyle(color: Colors.red)));
        },
      ),
      bottomNavigationBar: const HorizontalMenu(),
    );
  }
}
