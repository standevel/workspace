import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../form/team_members_invite.form.dart';

class InviteTeammatesPage extends HookConsumerWidget {
  const InviteTeammatesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                'Invite your team mates',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text('To do so, start typing their company email',
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.white70)),
              const SizedBox(
                height: 16.0,
              ),
              TeamMembersInviteForm(
                btnTitle: 'Start',
                navigateToDashboard: () =>
                    Navigator.pushNamed(context, '/dashboard'),
              )
            ],
          ),
        ),
      ),
    )));
  }
}
