import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateWorkspaceForm extends HookWidget {
  const CreateWorkspaceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: createForm(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReactiveTextField<String>(
              formControlName: 'workspaceName',
              // validationMessages: (control) => {
              //   ValidationMessage.required: 'Workspace name is required.',
              // },
              decoration: const InputDecoration(labelText: 'Workspace Name'),
            ),
            const SizedBox(height: 16),
            ReactiveTextField<String>(
              formControlName: 'description',
              // validationMessages: (control) => {
              //   ValidationMessage.required: 'Description is required.',
              // },
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitForm(context),
              child: const Text('Create Workspace'),
            ),
          ],
        ),
      ),
    );
  }

  FormGroup createForm() {
    return fb.group({
      'workspaceName': FormControl<String>(validators: [Validators.required]),
      'description': FormControl<String>(validators: [Validators.required]),
    });
  }

  void _submitForm(BuildContext context) {
    final form = ReactiveForm.of(context);
    if (form!.valid) {
      // Implement your create workspace logic here
      // You can access the form values using form.value
      // For example:
      // final workspaceName = form.value['workspaceName'];
      // final description = form.value['description'];
    }
  }
}
