import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/providers/provider.dart';

class HorizontalMenu extends HookConsumerWidget {
  const HorizontalMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToPage(String route) {
      Navigator.of(context).pushNamed(route);
    }

    var workspace = ref.watch(workspaceProvider)!;
    return Container(
      color: Theme.of(context).shadowColor,
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container(
          //   padding: const EdgeInsets.all(16.0),
          //   // color: Colors.blue,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       workspace.logoUrl != null
          //           ? Image.network(
          //               workspace.logoUrl!,
          //               scale: 1,
          //               fit: BoxFit.fitWidth,
          //             )
          //           : Text(
          //               workspace.name!,
          //               style: const TextStyle(fontSize: 18.0, color: white),
          //             ),
          //       const SizedBox(height: 8.0),

          //     ],
          //   ),
          // ),

          const SizedBox(width: 20.0),
          MenuItem(
            icon: Icons.group,
            title: "Teams/People",
            onTap: () {
              // Navigate to Teams/People page
              Navigator.of(context).pop();
              navigateToPage('/team');
              print("Navigate to Teams/People page");
            },
          ),
          MenuItem(
            icon: Icons.chat,
            title: "DM",
            onTap: () {
              // Navigate to Chat page
              Navigator.of(context).pop();
              navigateToPage('/dm');
              print("Navigate to Chat page");
            },
          ),
          MenuItem(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {
              // Navigate to Notifications page
              Navigator.of(context).pop();
              navigateToPage('/notification');
              print("Navigate to Notifications page");
            },
          ),
          MenuItem(
            icon: Icons.call,
            title: "Call",
            onTap: () {
              // Navigate to Call page
              Navigator.of(context).pop();
              navigateToPage('/call');
              print("Navigate to Call page");
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Tooltip(
          message: title,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(icon, size: 30),
          ),
        ),
      ),
    );
  }
}
