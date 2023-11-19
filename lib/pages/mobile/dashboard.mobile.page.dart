import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/model/workspace.dart';
import 'package:peersync/providers/provider.dart';
import 'package:peersync/widgets/vertical_menu.dart';
import '../../constants.dart';
import '../../widgets/drawer_sidebar.dart';
import '../../widgets/menu.dart';

class DashboardMobilePage extends HookConsumerWidget {
  DashboardMobilePage({super.key});
  late List<dynamic> workspaceList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspacesAsyncValue = ref.watch(workspacesProvider);
    return Scaffold(
      appBar: AppBar(),
      drawer: const sideDrawer(),
      body: workspacesAsyncValue.when(
        data: (workspaces) {
          // Data is available, you can render it on the UI
          workspaceList = workspaces!;

          return Row(children: [
            Container(
                constraints: const BoxConstraints(
                  maxWidth: 100.0,
                  // maxHeight: MediaQuery.of(context).size.height
                ),
                child: const VerticalMenu()),
            Flexible(
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: 300.0, maxWidth: 350.0), // Minimum width
                child: MenuList(),
              ),
            ),
            const Expanded(child: Text('Dashboard page')),
          ]);
        },
        loading: () {
          // Loading state, you can show a loading indicator
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          // Error state, you can show an error message
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}


// chat section color : F0F0F0F0
/**
 *  return Scaffold(
        appBar: AppBar(),
        drawer: const sideDrawer(),
        body: FutureBuilder<String>(
            future: workspacesProvider,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData && snapshot.data != null) {
                  return Row(children: [
                    Container(
                        constraints: const BoxConstraints(maxWidth: 100.0),
                        child: const VerticalMenu()),
                    Flexible(
                      flex: 1,
                      child: Container(
                        constraints: const BoxConstraints(
                            minWidth: 300.0, maxWidth: 350.0), // Minimum width
                        // child: MenuL ist(),
                      ),
                    ),
                    const Expanded(child: Text('Dashboard page')),
                  ]);
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, '/login');
                  });
                  return const Center(
                    child: Text('Redirecting to login...'),
                  );
                }
              }
            }));
 
 */