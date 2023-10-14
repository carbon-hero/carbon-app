import 'package:flutter/cupertino.dart';
import 'package:flutter_lifestyle/models/commute_history.dart';
import 'package:flutter_lifestyle/screens/authentication/login.dart';
import 'package:flutter_lifestyle/screens/authentication/otp_verification.dart';
import 'package:flutter_lifestyle/screens/authentication/register.dart';
import 'package:flutter_lifestyle/screens/intro/intro_screen.dart';
import 'package:flutter_lifestyle/screens/journey/contact_list.dart';
import 'package:flutter_lifestyle/screens/journey/search_location.dart';
import 'package:flutter_lifestyle/screens/journey/select_location.dart';
import 'package:flutter_lifestyle/screens/journey/start_journey.dart';
import 'package:flutter_lifestyle/screens/main/carbon_emission_screen.dart';
import 'package:flutter_lifestyle/screens/main/distance_coverd_screen.dart';
import 'package:flutter_lifestyle/screens/main/feedback_screen.dart';
import 'package:flutter_lifestyle/screens/main/points_scored_screen.dart';
import 'package:flutter_lifestyle/screens/main/trees_plant_screen.dart';
import 'package:flutter_lifestyle/screens/main_screen.dart';
import 'package:flutter_lifestyle/screens/profile/edit_profile.dart';
import 'package:flutter_lifestyle/screens/splash.dart';
import 'package:page_transition/page_transition.dart';


class Routes {
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otpVerification';
  static const String main = '/main';
  static const String editProfile = '/editProfile';
  static const String startJourney = '/startJourney';
  static const String contactList = '/contactList';
  static const String selectLocation = '/selectLocation';
  static const String searchLocation = '/searchLocation';
  static const String carbonEmission = '/carbonEmission';
  static const String distanceCover = '/distanceCover';
  static const String pointScore = '/pointScore';
  static const String treePlanted = '/treePlanted';
  static const String feedback = '/feedback';
}

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return fadePageTransition(SplashScreen());
      case Routes.intro:
        return fadePageTransition(IntroScreen());
      case Routes.login:
        return fadePageTransition(LoginScreen());
      case Routes.register:
        return fadePageTransition(RegisterScreen());
      case Routes.otpVerification:
        return fadePageTransition(OTPVerificationScreen(settings.arguments as String));
      case Routes.main:
        return fadePageTransition(MainScreen());
      case Routes.editProfile:
        return fadePageTransition(EditProfileScreen());
      case Routes.startJourney:
        return fadePageTransition(StartJourneyScreen());
      case Routes.contactList:
        return fadePageTransition(ContactListScreen());
      case Routes.selectLocation:
        return fadePageTransition(SelectLocationScreen());
      case Routes.searchLocation:
        return fadePageTransition(SearchLocationScreen(settings.arguments as bool));
      case Routes.carbonEmission:
        return fadePageTransition(CarbonEmissionScreen());
      case Routes.distanceCover:
        return fadePageTransition(DistanceCoverdScreen());
      case Routes.pointScore:
        return fadePageTransition(PointScoreScreen());
      case Routes.treePlanted:
        return fadePageTransition(TreePlantScreen());
      case Routes.feedback:
        return fadePageTransition(FeedbackScreen(settings.arguments as CommuteHistory));
      default:
        return null;
    }
  }

  static PageTransition fadePageTransition(Widget screen,
      {RouteSettings? settings}) {
    return PageTransition(
        child: screen, type: PageTransitionType.fade, settings: settings);
  }

  static PageTransition rightToLeftTransition(Widget screen,
      {RouteSettings? settings}) {
    return PageTransition(
      child: screen,
      type: PageTransitionType.rightToLeft,
      settings: settings,
    );
  }

  static PageTransition bottomToTopTransition(Widget screen,
      {RouteSettings? settings}) {
    return PageTransition(
      child: screen,
      type: PageTransitionType.bottomToTop,
      settings: settings,
    );
  }
}

class OTPArgs {
  final String? registerId;
  final bool? isLogin;
  final String? type;
  final String? messageText;

  OTPArgs({
    this.registerId,
    this.isLogin,
    this.type,
    this.messageText,
  });
}
