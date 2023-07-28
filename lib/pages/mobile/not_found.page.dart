import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Placeholder(
      child: Text('Page Not Found!'),
    ));
  }
}
