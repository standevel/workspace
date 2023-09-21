import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../constants.dart';
import '../providers/provider.dart';
import '../utils/custom_httpclient.dart';

class TeamMembersInviteForm extends ConsumerWidget {
  final VoidCallback navigateToDashboard;
  final String btnTitle;
  const TeamMembersInviteForm(
      {super.key, required this.btnTitle, required this.navigateToDashboard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var workspace = ref.read(workspaceProvider);
    var form = createForm(workspace);
    debugPrint('team members invite: $workspace');
    var isProcessing = ref.watch(loadingProvider);
    (form.control('teammates') as FormArray<String>).add(FormControl<String>());
    (form.control('teammates') as FormArray<String>).add(FormControl<String>());
    (form.control('teammates') as FormArray<String>).add(FormControl<String>());
    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Add as many teammates as possible',
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.white70)),
            ReactiveFormArray<String>(
              formArrayName: 'teammates',
              builder: (context, formArray, child) {
                return Column(
                  children: formArray.controls.map((control) {
                    return Row(
                      children: [
                        Expanded(
                          child: RoundedPlainTextField(
                            hintText: 'Enter teammate company email',
                            formControl: control as FormControl<String>,
                            validationMessages: {
                              ValidationMessage.required: (contro) =>
                                  'This teammate email is required',
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
                    print('add teammate clicked');

                    (form.control('teammates') as FormArray<String>)
                        .add(FormControl<String>());
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text('Add Teammate'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SubmitForm(
              onPressed: () => _submitForm(context, ref, form),
              title: btnTitle,
            ),
            if (isProcessing)
              const CircularProgressIndicator(
                color: white,
              )
          ],
        ),
      ),
    );
  }

  FormGroup createForm(dynamic workspace) {
    return fb.group({
      'teammates': FormArray<String>([], validators: [Validators.minLength(1)]),
    });
  }

  void _submitForm(BuildContext context, WidgetRef ref, FormGroup form) async {
    ref.read(loadingProvider.notifier).state = true;
    var workspace = ref.read(workspaceProvider);
    var token = ref.read(tokenProvider);
    if (token == '' || token == 'null') {
      token = await checkUserToken();
      debugPrint('token from provider inner $token');
    }
    // var workspace = ref.read(workspaceProvider);
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
          'workspace/invite-teammate',
          {
            ...form.value,
            "workspace": workspace!.name,
            "workspaceId": workspace.id
          },
        );

        if (response.statusCode == 201) {
          var body = jsonEncode(response.body);
          debugPrint('workspace: $body');
          ref.read(loadingProvider.notifier).state = false;
          navigateToDashboard();
        } else {
          debugPrint('status code: ${response.statusCode}');
          ref.read(loadingProvider.notifier).state = false;
        }
      } catch (e) {
        debugPrint("Error inviting teammates ${e.toString()}");
        ref.read(loadingProvider.notifier).state = false;
      }
    }
  }
}
