import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/app_dialog.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/snakbar.dart';
import 'package:flutter_lifestyle/models/user.dart';
import 'package:flutter_lifestyle/networking/api_response.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/repository/auth_repository.dart';
import 'package:flutter_lifestyle/screens/main_screen.dart';
import 'package:provider/provider.dart';

AuthProvider getAuthStore(BuildContext context) {
  var store = Provider.of<AuthProvider>(context, listen: false);
  return store;
}

class AuthProvider extends ChangeNotifier {

  AuthRepository repository = AuthRepository();

  bool loading = false;

  bool get isLoading => loading;

  changeLoadingStatus(bool val) {
    loading = val;
    notifyListeners();
  }

  User? authUser;

  Future<void> login(Map<String, dynamic> params) async {
    try {
      changeLoadingStatus(true);
      ApiResponse? apiResponse = await repository.login(params);
      changeLoadingStatus(false);
      if (apiResponse == null || apiResponse.statusCode == 404) {
        AlertSnackBar.error(apiResponse!.message!);
      } else {
        AlertSnackBar.success(apiResponse.message!);
        getUserStore(NavigationService.context).getAllSetting();
        authUser = User.fromJson(apiResponse.data);
        getUserStore(NavigationService.context).changeUser(authUser!);
        SharedPref.pref!.setBool(Preferences.isLogin, true);
        SharedPref.pref!.setString(Preferences.token, authUser!.token);
        Navigator.of(NavigationService.context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainScreen()),
                (Route<dynamic> route) => false);
      }
    } catch (e) {
      changeLoadingStatus(false);
      print(e.toString());
    }
  }

  Future<void> register(Map<String, dynamic> params) async {
    try {
      changeLoadingStatus(true);
      ApiResponse? apiResponse = await repository.register(params);
      changeLoadingStatus(false);
      if (apiResponse == null || apiResponse.statusCode == 404) {
        AlertSnackBar.error(apiResponse!.message!);
      } else {
        AlertSnackBar.success(apiResponse.message!);
        authUser = User.fromJson(apiResponse.data);
        getUserStore(NavigationService.context).changeUser(authUser!);
        SharedPref.pref!.setBool(Preferences.isLogin, true);
        SharedPref.pref!.setString(Preferences.token, authUser!.token);
        Navigator.of(NavigationService.context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainScreen()),
                (Route<dynamic> route) => false);
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      print(e.toString());
    }
  }

}