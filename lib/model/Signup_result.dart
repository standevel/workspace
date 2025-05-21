import 'package:peersync/model/user.dart';

class SignUpResult {
  String accessToken;
  User user;

  SignUpResult(this.accessToken, this.user);
}
