import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:package_info_plus/package_info_plus.dart';


import '../helper/colors.dart';
import '../helper/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isIntroDone = SharedPref.pref!.getBool(Preferences.isIntroDone) ?? false;
  bool isLogin = SharedPref.pref!.getBool(Preferences.isLogin) ?? false;

  navigateRoutes() async {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      if (isIntroDone) {
        if (isLogin) {
          getUserStore(context).getAllSetting();
          await getUserStore(context).getUser();
          NavigationService.navigateToReplacement(Routes.main);
        } else {
          NavigationService.navigateToReplacement(Routes.login);
        }
      } else {
        NavigationService.navigateToReplacement(Routes.intro);
      }
    });
  }



  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    navigateRoutes();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.padding_60),
              child: SvgPicture.asset(
                Images.lifeStyle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.dimen_30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Version ${_packageInfo.version}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: Dimens.fontSize_12,
                        color: textColor,
                        fontFamily: Fonts.medium),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
