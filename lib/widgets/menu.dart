import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/provider.dart';

class MenuList extends HookConsumerWidget {
  MenuList({super.key});

  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    // ... add more items
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTeamsAsyncValue = ref.watch(userTeamsProvider);

    return userTeamsAsyncValue.when(
      data: (teams) {
        return ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            final team = teams[index];

            return ListTile(
              title: Text(team.name.toString()),
              subtitle: Text('Subtitle for ${team.name}'),
              trailing: DropdownButton<String>(
                onChanged: (String? newValue) {
                  // Handle dropdown item selection here
                },
                items: <String>['Action 1', 'Action 2', 'Action 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              onTap: () {
                // Handle team item tap
                print('Tapped on: ${team.name}');
              },
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error loading teams: $error'),
    );
  }
}
