import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/providers/provider.dart';
import 'package:peersync/providers/socket_manager.dart';

import '../model/channel.dart';
import '../model/team.dart';

class MenuList extends HookConsumerWidget {
  // final List<Map<String, dynamic>> teams; // Replace with your data structure
  final List<Map<String, dynamic>> dropdownItems = [
    {
      'name': 'Add Member',
      'icon': Icons.add,
    },
    {
      'name': 'Archive Team',
      'icon': Icons.archive,
    },
    {
      'name': 'Mute Notification',
      'icon': Icons.notifications_off,
    },
  ];
  MenuList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SocketManager manager = SocketManager();
    var teams = ref.read(teamsProvider)!;
    List<String> channelIds = [];

    var workspace = ref.read(workspaceProvider)!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.people,
                color: Theme.of(context).shadowColor,
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Expanded(
                child: Text(
                  'Your Teams',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
              TextButton(
                child: const Row(
                  children: [Icon(Icons.add), Text('New Team')],
                ),
                onPressed: () => {print('new team button clicked')},
              )
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: teams.length,
          itemBuilder: (context, index) {
            final team = teams.elementAt(index);
            return CustomDropdownItem(
                team: team, // Adjust to match your data structure
                dropdownItems: dropdownItems,
                ref: ref // Adjust to match your data structure
                );
          },
        ),
        if (workspace.publicChannels != null &&
            workspace.publicChannels!.isNotEmpty)
          ListView.builder(
            shrinkWrap: true, // Adjust as needed
            itemCount: workspace.publicChannels!.length,
            itemBuilder: (context, index) {
              // Display public channels here
              var channel = workspace.publicChannels!.elementAt(index);
              return ListTile(
                title: Row(
                  children: [
                    const Text(
                      '#',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      channel['name']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                // Handle channel item tap
                onTap: () {
                  // You can use 'channel' here to access channel details
                  ref.read(activeChannelProvider.notifier).state =
                      Channel.fromJson(channel);
                },
              );
            },
          ),
      ],
    );
    // : const Text('You have not been added to a team yet');
  }
}

class CustomDropdownItem extends StatefulWidget {
  final Team team;
  final List<Map<String, dynamic>> dropdownItems;
  final WidgetRef ref;
  const CustomDropdownItem(
      {super.key,
      required this.team,
      required this.dropdownItems,
      required this.ref});

  @override
  _CustomDropdownItemState createState() => _CustomDropdownItemState();
}

class _CustomDropdownItemState extends State<CustomDropdownItem> {
  bool isExpanded = false;
  bool showAdd = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onHover: (value) => {
            setState(() {
              // print('hover value: $value');
              showAdd = value;
            })
          },
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.team.name!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black87,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                if (showAdd)
                  IconButton(
                      onPressed: () => {print('add to team')},
                      icon: Icon(
                        Icons.settings_applications_sharp,
                        color: Colors.blueGrey[800],
                      ))
              ],
            ),
          ),
        ),
        if (isExpanded)
          Column(
            children: widget.team.channels!.map((channel) {
              return ListTile(
                title: Row(
                  children: [
                    const Text(
                      '#',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      channel['name']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                // Handle channel item tap
                onTap: () {
                  // print('selected channel: $channel');
                  widget.ref.read(activeChannelProvider.notifier).state =
                      Channel.fromJson(channel);
                  // You can use 'channel' here to access channel details
                },
              );
            }).toList(),
          ),
      ],
    );
  }
}

 // kingstanley.ks16@gmail.com