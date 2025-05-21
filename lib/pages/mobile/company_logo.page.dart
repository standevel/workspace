import 'package:flutter/material.dart';
import 'package:peersync/form/company_logo.form.dart';

class CompanyLogoPage extends StatelessWidget {
  const CompanyLogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Company Logo')),
      body: const Center(child: CompanyLogoForm()),
    );
  }
}
