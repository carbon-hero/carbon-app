import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
  static SharedPreferences? pref;
}

class Preferences {
  Preferences._();

  static const String isLogin = 'is_user_login';
  static const String isIntroDone = 'is_intro_done';
  static const String token = 'is_token';
  static const String mapKey = 'is_map_key';
}
