import '../../../models/user_model.dart';
import '../../../services/auth_services.dart';
import '../base/controller.dart';

class RegisterController extends AuthController {
  RegisterController() : super(["FirstName", "LastName", "Email", "Phone", "Password", "Confirm Password"]);

  final _authService = AuthService();

  @override
  Future<bool> authenticate() async {
    if (formKey.currentState!.validate()) {
      final response = await _authService.register(
      getFieldValue("FirstName").trim(),
      getFieldValue("LastName").trim(),
      getFieldValue("Phone").trim(),
      "الزقازيق",
      getFieldValue("Email").trim(),
      getFieldValue("Password").trim(),
      );

      if (response["state"] == true) {
        UserModel userModel = UserModel.fromJson(response["data"]);
        return true;
      }
    }

    return false;
  }
}
