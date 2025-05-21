// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:peersync/widgets/plain_rounded_textfield.dart';
import 'package:peersync/widgets/submit_button.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../model/user.dart';
import '../providers/provider.dart';
import '../widgets/custom-snackbar.dart';

class LoginForm extends HookConsumerWidget {
  final FormGroup form;
  final VoidCallback navigateToDashboard;
  LoginForm({required this.navigateToDashboard, super.key})
      : form = createForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isProcessing = ref.watch(loadingProvider);
    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          RoundedPlainTextField(
            formControlName: 'email',
            validationMessages: {
              ValidationMessage.required: (error) => 'Email is required.',
              ValidationMessage.email: (control) =>
                  'Please enter a valid email address.',
            },
            labelText: 'Email',
            hintText: 'Enter your email',
            icon: Icons.email,
          ),
          RoundedPlainTextField(
            formControlName: 'password',
            obscureText: true,
            validationMessages: {
              ValidationMessage.required: (control) => 'Password is required.',
              ValidationMessage.minLength: (control) =>
                  'minimum password length is 8'
            },
            labelText: 'Password',
            hintText: 'Enter your password',
            icon: Icons.password,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(''),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/forgot-password');
                },
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Theme.of(context).shadowColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Forgot password?'),
              ),
            ],
          ),
          SubmitForm(
              title: 'Login', onPressed: () => _submitForm(context, ref)),
          if (isProcessing)
            const CircularProgressIndicator(
              color: white,
            )
        ]),
      ),
    );
  }

  static FormGroup createForm() {
    return fb.group({
      'email': FormControl<String>(validators: [
        Validators.required,
        Validators.email,
      ]),
      'password': FormControl<String>(validators: [
        Validators.required,
        Validators.minLength(8),
      ]),
    });
  }

  void _submitForm(BuildContext context, WidgetRef ref) async {
    if (form.valid) {
      try {
        ref.watch(loadingProvider.notifier).state = true;
        var url = Uri.parse('$api/account/signin');
        var response = await http.post(url, body: form.value);
        print('body: ${response.statusCode}');
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);

// save user to objectbox
          // final userBox = store.box<UserEntity>();

          // debugPrint('workspace: $body');
          var user = body['user'];
          var token = body['access_token'];

          // debugPrint('user: $user');
          debugPrint('access_token: $token');

          // CherryToast.info(
          //   title: const Text('login successful'),
          //   description: const Text(
          //       'login successful. We are redirecting you to dashboard'),
          //   actionHandler: () {},
          // ).show(context);

          ref.read(tokenProvider.notifier).state = token;
          ref.read(userProvider.notifier).state = User.fromJson(user);
          // var activeWorkspace = user['workspaces'][0];
          // var workspacesList = user['workspaces'] as List<dynamic>;
          // print('workspace list: $workspacesList');
          // var workspaces = workspacesList
          //     .map((workspace) => Workspace.fromJson(workspace))
          //     .toList();
          // ref.read(workspacesProvider.notifier).state = workspaces;
          // var workspace = workspaces.elementAt(0);

          // final List<dynamic> teamDataList = workspace.teams!;
          // final List<Team> teamsData =
          //     teamDataList.map((team) => Team.fromJson(team)).toList();

          // ref.read(teamsProvider.notifier).state = teamsData;

          // var worksp = ref.read(workspaceProvider.notifier).state = workspace;

          // var teams = ref.read(teamsProvider);

          // print('active workspace: $worksp teams: $teams');

          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: 'Authorized!',
              iconData: Icons.info, // Specify the icon you want
              onClose: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          );
          // Obtain shared preferences.
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(tokenName, token);

          setLoggedIn(true);
          setUser(user);
          ref.read(userProvider.notifier).state = User.fromJson(user);
          // setActiveWorkspace(workspacesList.elementAt(0));
          // setWorkspaceList(workspacesList);
// save user object to db

          print('saved user: ');
          // }

          navigateToDashboard();
        } else {
          debugPrint('status code: ${response.statusCode}');
          // var snackBar = response.statusCode == 401
          //     ? const SnackBar(
          //         showCloseIcon: true,
          //         content: Text('Invalid email or password!'),
          //         duration: Duration(
          //             seconds: 3), // Control how long the snackbar is displayed
          //       )
          //     : const SnackBar(
          //         content: Text('Login Failed!'),
          //         duration: Duration(
          //             seconds: 3), // Control how long the snackbar is displayed
          //       );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);

          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              color: Colors.red,
              message: 'Authorization failed! Invalid email or password',
              iconData: Icons.info, // Specify the icon you want
              onClose: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          );
          ref.read(loadingProvider.notifier).state = false;
        }
      } catch (e) {
        debugPrint("Error in sign in ${e.toString()}");
        ref.read(loadingProvider.notifier).state = false;
        // const snackBar = SnackBar(
        //   content: Text( 'Login Failed!'),
        //   duration: Duration(
        //       seconds: 3), // Control how long the snackbar is displayed
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
