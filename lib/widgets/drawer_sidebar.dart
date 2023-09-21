import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/providers/provider.dart';

class sideDrawer extends HookConsumerWidget {
  // final List<dynamic> workspaces;
  const sideDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workspaces = ref.watch(workspacesProvider);
    // var workspaces = userPro?.workspaces?.toList();
    print('workspaces: ${workspaces?.toList()}');
    return Drawer(
      child: ListView(
        children: [
          // Your logo at the top
          SizedBox(
              height: 200.0, // Set the maximum height for the logo
              child: Stack(children: [
                Image.asset('assets/images/peersync.png'),
                const Center(
                    child: Text(
                  'Your Workspaces',
                  style: TextStyle(
                    color: Colors.white, // Customize text color
                    fontSize: 20.0, // Customize text size
                  ),
                ))
              ]) //
              ),

          // Divider or spacing between the logo and workspace list
          const Divider(),

          // Workspace list
          ListView.builder(
            shrinkWrap:
                true, // Ensures that the list takes up only as much space as needed
            physics:
                const NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
            itemCount: workspaces?.length,
            itemBuilder: (context, index) {
              final workspace = workspaces?[index];

              return Tooltip(
                message: workspace!.name,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: workspace.logoUrl != null
                        ? NetworkImage(workspace.logoUrl!, scale: 1)
                        : null,
                    child: Text(workspace.name!.toString().substring(0, 1)),
                  ),
                  title: Text(workspace.name!),
                  onTap: () {
                    // Handle tapping on a workspace item
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
