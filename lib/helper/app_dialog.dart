import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/screens/dialog/logout_dialog.dart';
import 'package:flutter_lifestyle/screens/profile/choose_profile_dialog.dart';

class AppDialog {
  static chooseProfileDialog(
      {required BuildContext context, required Function(File file) onTap}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.radius_30),
        ),
      ),
      builder: (BuildContext context) {
        return ChooseProfileDialog(onTap);
      },
    );
  }

  static logoutDialog(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: white,
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog();
      },
    );
  }

}
