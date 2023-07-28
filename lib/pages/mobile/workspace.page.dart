import 'package:flutter/material.dart';
import 'package:peersync/form/workspace.form.dart';

class CreateWorkspacePage extends StatelessWidget {
  const CreateWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Workspace')),
      body: const Center(child: CreateWorkspaceForm()),
    );
  }
}
