import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompanyLogoForm extends HookWidget {
  const CompanyLogoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final logoFile = useState<File?>(null);

    return ReactiveForm(
      formGroup: createForm(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            logoFile.value != null
                ? Image.file(logoFile.value!)
                : const Placeholder(),
            ElevatedButton(
              onPressed: () => _pickLogo(context, logoFile),
              child: const Text('Pick Logo'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _uploadLogo(context, logoFile.value),
              child: const Text('Upload Logo'),
            ),
          ],
        ),
      ),
    );
  }

  FormGroup createForm() {
    return fb.group({});
  }

  void _pickLogo(BuildContext context, ValueNotifier<File?> logoFile) async {
    // Implement logic to pick the logo file from the gallery or camera
  }

  void _uploadLogo(BuildContext context, File? logoFile) async {
    // Implement logic to upload the logo file to the server or cloud storage
  }
}
