import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<bool> setAuthtoken(String token) async {
    final pref = await SharedPreferences.getInstance();

    return pref.setString(UserPref.AuthToken.toString(), token);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(UserPref.AuthToken.toString());
  }

  Future<Future<bool>> logoutAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(UserPref.AuthToken.toString());
  }
}

enum UserPref {
  AuthToken,
}
