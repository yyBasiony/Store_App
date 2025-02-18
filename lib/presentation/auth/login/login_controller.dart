import '../../../models/user_model.dart';
import '../../../services/auth_services.dart';
import '../base/controller.dart';

class LoginController extends AuthController {
  LoginController() : super(["Email", "Password"]);

  final _authService = AuthService();

  @override
  Future<bool> authenticate() async {
    if (formKey.currentState!.validate()) {
      final response = await _authService.login(
          getFieldValue("Email"), getFieldValue("Password"));
      if (response["state"] == true) {
        UserModel userModel = UserModel.fromJson(response["data"]);
        return true;
      }
    }

    return false;
  }
}
