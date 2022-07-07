import 'package:post_api_app/login_sharedPref/helpers/sp_helper.dart';

class Api {
  Future<void> loginUser() async {
    String token = "asdasda";
    await SharedPreferenceHelper().setAuthtoken(token);
  }
}
