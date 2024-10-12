import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences pref;
  static Future<SharedPreferences> init() async =>
      pref = await SharedPreferences.getInstance();

  ///isloggedin
  ///
  /// 0 - LoginScreen ,
  ///
  /// 1  - LoggedIn (Batch List Screen),
  static void isLoggedin(int value) => pref.setInt("isloggedin", value);
  static void setUserName(String value) => pref.setString("user_name", value);
  static void setPassword(String value) => pref.setString("password", value);
  static void setUserID(String value) => pref.setString("user_id", value);

  /// trip_id of the route sales are stored here

  ///isloggedin
  ///
  /// 0 - LoginScreen ,
  ///
  /// 1  - LoggedIn (Batch List Screen),
  static int? getLogginStatus() => pref.getInt("isloggedin");
  static String? getuserName() => pref.getString("user_name");
  static String? getPassword() => pref.getString("password");
  static String? getUserID() => pref.getString("user_id");

  // static getUserID() {}
}
