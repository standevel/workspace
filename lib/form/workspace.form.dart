import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../providers/provider.dart';
import '../utils/header_with_token.utils.dart';

class CreateWorkspaceForm extends ConsumerWidget {
  final VoidCallback navigateToDashboard;
  const CreateWorkspaceForm({super.key, required this.navigateToDashboard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workspace = ref.read(workspaceProvider);
    var form = createForm(workspace);
    debugPrint('workspace: $workspace');

    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RoundedPlainTextField(
                formControlName: 'workspace',
                value: workspace?.workspace.toString(),
                // validationMessages: (control) => {
                //   ValidationMessage.required: 'Workspace name is required.',
                // },
                borderRadius: 26,
                labelText: 'Workspace Name',
                hintText: 'Workspace or company name'),
            // const SizedBox(height: 16),
            // const RoundedPlainTextField(
            //   formControlName: 'description',
            //                   borderRadius: 26,
            //   labelText: 'Description',
            //   hintText: 'Description your workspace',
            // ),
            const Text('Add as many teams as you have',
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.white70)),
            ReactiveFormArray<String>(
              formArrayName: 'teams',
              builder: (context, formArray, child) {
                return Column(
                  children: formArray.controls.map((control) {
                    return Row(
                      children: [
                        Expanded(
                          child: RoundedPlainTextField(
                            hintText: 'Enter team name',
                            formControl: control as FormControl<String>,
                            validationMessages: {
                              ValidationMessage.required: (contro) =>
                                  'This field is required',
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => formArray.remove(control),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),

            //
            Row(
              children: [
                const Expanded(child: Text('')),
                TextButton(
                  onPressed: () {
                    print('add team clicked');

                    (form.control('teams') as FormArray<String>)
                        .add(FormControl<String>());
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text('Add Team'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SubmitForm(
              onPressed: () => _submitForm(context, ref, form),
              title: 'Create Workspace',
            ),
          ],
        ),
      ),
    );
  }

  FormGroup createForm(dynamic workspace) {
    return fb.group({
      'workspace': FormControl<String>(
        value: workspace.workspace.toString(),
        validators: [Validators.required],
      ),
      // 'description': FormControl<String>(validators: [Validators.required]),
      'teams': FormArray<String>([], validators: [Validators.minLength(1)]),
      'logo': FormControl<String>(),
      'isCompany': FormControl<bool>(value: false),
    });
  }

  void _submitForm(BuildContext context, WidgetRef ref, FormGroup form) async {
    var token = ref.read(tokenProvider);
    var workspace = ref.read(workspaceProvider);
    debugPrint('token from provider $token');
    final httpClient = CustomHttpClient(bearerToken: token);

    print('work space create click');
    print('form state: ${form.valid} ${form.value}');
    if (form.valid) {
      ref.read(errorProvider.notifier).state = '';
      ref.watch(loadingProvider.notifier).state = true;
      print('Sign up form is valid');

      // var url = Uri.parse('$api/workspace');
      try {
        var response = await httpClient.post(
          'workspace',
          {...form.value, "isCompany": workspace?.isCompnay},
        );

        if (response.statusCode == 201) {
          var body = jsonEncode(response.body);
          debugPrint('workspace: $body');
          navigateToDashboard();
        } else {
          debugPrint('status code: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint("Error creating workspace ${e.toString()}");
      }
    }
  }
}