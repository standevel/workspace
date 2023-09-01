import 'package:http/http.dart' as http;
import 'package:peersync/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Validator that validates the user's email is unique, sending a request to
/// the Server.
class UniqueEmailAsyncValidator extends AsyncValidator<dynamic> {
  @override
  Future<Map<String, dynamic>?> validate(
      AbstractControl<dynamic> control) async {
    final error = {'Email already exist': false};

    final isUniqueEmail = await _getIsUniqueEmail(control.value.toString());
    print('isUniqueEmail: $isUniqueEmail');
    if (!isUniqueEmail) {
      control.markAsTouched();
      print('unique status: $error');
      return error;
    }

    return null;
  }

  /// Simulates a time consuming operation (i.e. a Server request)
  Future<bool> _getIsUniqueEmail(String email) async {
    try {
      // simple array that simulates emails stored in the Server DB.
      var url = Uri.parse('$api/account/check-email-exist?email=$email');
      final headers = {'Content-Type': 'application/json'};
      var response = await http.get(url, headers: headers);
      // print('Response status: ${response.statusCode} ${response.body}');
      // var body = jsonDecode(response.body);
      // var exist = body['exist'];
      // print('email exist: $exist');
      // return body['exist'];
      if (response.statusCode == 409) {
        return Future(() => false);
      }
      return Future.value(true);
    } catch (e) {
      print('error in catch: $e');
      return Future(() => false);
    }
  }
}
