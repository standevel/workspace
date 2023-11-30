import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/model/workspace.dart';
import 'package:peersync/pages/mobile/call.mobile.dart';
import 'package:peersync/pages/mobile/chat.mobile.dart';
import 'package:peersync/providers/provider.dart';
import 'package:peersync/widgets/horizontal_menu.dart';
import 'package:peersync/widgets/vertical_menu.dart';
import '../../constants.dart';
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

          return Row(children: [
            Container(
                constraints: const BoxConstraints(
                  maxWidth: 100.0,
                  // maxHeight: MediaQuery.of(context).size.height
                ),
                child: const VerticalMenu()),
            Expanded(
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: 300.0, maxWidth: 350.0), // Minimum width
                child: MenuList(),
              ),
            ),
            Expanded(child: ChannelWidget()),
          ]);
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
          return Center(child: Text('Error: $error'));
        },
      ),
      bottomNavigationBar: const HorizontalMenu(),
    );
  }
}
