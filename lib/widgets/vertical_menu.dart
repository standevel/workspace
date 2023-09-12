import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/providers/provider.dart';

class VerticalMenu extends HookConsumerWidget {
  const VerticalMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).shadowColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            // color: Colors.blue,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/peersync.png'),
                  // width: 100.0,
                  // height: 100.0,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 8.0),
                // Text(
                //   "Peer Sync",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 12,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          MenuItem(
            icon: Icons.group,
            title: "Teams/People",
            onTap: () {
              // Navigate to Teams/People page
              print("Navigate to Teams/People page");
            },
          ),
          MenuItem(
            icon: Icons.chat,
            title: "Chat",
            onTap: () {
              // Navigate to Chat page
              print("Navigate to Chat page");
            },
          ),
          MenuItem(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {
              // Navigate to Notifications page
              print("Navigate to Notifications page");
            },
          ),
          MenuItem(
            icon: Icons.call,
            title: "Call",
            onTap: () {
              // Navigate to Call page
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
