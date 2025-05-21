import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:peersync/form/workspace.form.dart';

class CreateWorkspacePage extends HookWidget {
  const CreateWorkspacePage({super.key});
  @override
  Widget build(BuildContext context) {
    // 1. watch the provider and rebuild when the value changes
    // final counter = ref.watch(teamControlsProvider);
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: 400,
      height: 500,
      child: SingleChildScrollView(
        child: Card(
          color: Colors.blueGrey[800],
          elevation: 12.0,
          child: Column(
            children: [
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'Set up your workspace',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text('Now name your workspace and add teams',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.white70)),
              const SizedBox(
                height: 16.0,
              ),
              CreateWorkspaceForm(
                navigateToInviteTeammate: () =>
                    Navigator.pushNamed(context, '/invite-teammates'),
              )
            ],
          ),
        ),
      ),
    )));
  }
}


//  ElevatedButton(
//       // 2. use the value
//       child: Text('Value: $counter'),
//       // 3. change the state inside a button callback
//       onPressed: () => ref.read(counterStateProvider.notifier).state++,
//     );