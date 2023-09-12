import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyEmailPage extends HookConsumerWidget {
  const VerifyEmailPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = Uri.base.queryParameters["token"];
    return const Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Hold on while we verify your email'),
          SizedBox(
            height: 12.0,
          ),
          CircularProgressIndicator(
            color: Colors.white,
          )
        ]),
      ),
    );
  }
}
