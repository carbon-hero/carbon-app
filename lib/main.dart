import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/location_provider.dart';
import 'package:flutter_lifestyle/screens/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

import 'provider/auth_provider.dart';
import 'provider/user_provider.dart';

Location mainLocation = Location();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.pref = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<LocationProvider>(create: (_) => LocationProvider()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, snapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LifeStyle',
              theme: ThemeData(
                fontFamily: Fonts.medium,
                primaryColor: primaryColor,
              ),
              navigatorKey: NavigationService.navigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              home: SplashScreen(),
            );
          },),
      ),
    );
  }
}
