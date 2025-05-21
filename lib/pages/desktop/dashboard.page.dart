import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/enums/event_type.enum.dart';
import 'package:peersync/providers/socket_manager.dart';

import '../../providers/provider.dart';
import '../../utils/event_handler.dart';
import '../../widgets/channel.dart';
import '../../widgets/drawer_sidebar.dart';
import '../../widgets/menu.dart';
import '../../widgets/vertical_menu.dart';

class TeamDashboardDesktopPage extends HookConsumerWidget {
  const TeamDashboardDesktopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspacesAsyncValue = ref.watch(workspacesProvider);
    SocketManager manager = SocketManager();
    manager.socket.on(EVENT, (payload) {
      handleEvent(payload);
    });
    return Scaffold(
      appBar: AppBar(),
      drawer: const sideDrawer(),
      body: workspacesAsyncValue.when(
        data: (workspaces) {
          return Card(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 100.0,
                  ),
                  child: const VerticalMenu(),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    constraints: const BoxConstraints(
                      minWidth: 300.0,
                      maxWidth: 350.0,
                    ),
                    child: MenuList(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ChannelWidget(),
                ),
              ],
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
