import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/screens/authentication/login.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';

import '../../helper/colors.dart';
import '../../helper/strings.dart';

class LogoutDialog extends StatefulWidget {


  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Logout",
            style: TextStyle(
                color: primaryColor,
                fontFamily: Fonts.semiBold,
                fontSize: 18,
                letterSpacing: -0.2),
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          color: Theme.of(context).dividerColor,
        ),
        Text(
          "Are you sure you want to logout?",
          style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
              fontFamily: Fonts.medium,
              fontSize: 17,
              letterSpacing: -0.2),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  label: Constants.cancel,
                  height: Dimens.height_45,
                  backgroundColor: Colors.transparent,
                  borderColor: textColor,
                  textColor: textColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: AppButton(
                  label: Constants.logout,
                  height: Dimens.height_45,
                  onPressed: () {
                    SharedPref.pref!.setString(Preferences.token, "");
                    SharedPref.pref!.setBool(Preferences.isLogin, false);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        ModalRoute.withName("/login"));
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
