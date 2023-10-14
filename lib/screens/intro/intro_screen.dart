import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/routes.dart';
import '../../helper/strings.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (value) {
                setState(() => currentIndex = value);
              },
              children: [
                pageView(
                    icon: Images.introSlider1,
                    title: Constants.introTitle1,
                    subText: Constants.introDes1,
                    index: 0),
                pageView(
                    icon: Images.introSlider2,
                    title: Constants.introTitle2,
                    subText: Constants.introDes2,
                    index: 1),
                pageView(
                    icon: Images.introSlider3,
                    title: Constants.introTitle3,
                    subText: Constants.introDes3,
                    index: 2),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              SharedPref.pref!.setBool(Preferences.isIntroDone, true);
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
            child: Text(
              Constants.skip,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: hintTextColor,
                  fontSize: Dimens.fontSize_14,
                  fontFamily: Fonts.bold),
            ),
          ),
          SizedBox(height: Dimens.height_20,),
          Padding(
            padding: EdgeInsets.all( Dimens.padding_20),
            child: Column(
              children: [
                DotsIndicator(
                  dotsCount: 3,
                  position: currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    color: inactiveColor,
                    size: const Size.square(8),
                    spacing: const EdgeInsets.all(2),
                    activeSize: const Size(20.0, 10.0),
                    activeColor: primaryColor,
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: Dimens.height_40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (currentIndex != 0) {
                          controller.animateToPage(currentIndex - 1,
                              curve: Curves.decelerate,
                              duration: const Duration(milliseconds: 300));
                        }
                      },
                      child: currentIndex == 0
                          ? const SizedBox()
                          : SvgPicture.asset(Images.back),
                    ),
                    AppButton(
                      label: Constants.next,
                      width: Dimens.width_90,
                      height: 40,
                      textSize: Dimens.fontSize_12,
                      onPressed: () {
                        if (currentIndex == 2) {
                          SharedPref.pref!.setBool(Preferences.isIntroDone, true);
                          Navigator.of(context).pushReplacementNamed(Routes.login);
                        } else {
                          controller.animateToPage(currentIndex + 1,
                              curve: Curves.decelerate,
                              duration: const Duration(milliseconds: 300));
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget pageView({String? icon, String? title, String? subText, int? index}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          SvgPicture.asset(
            icon!,
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Column(
            children: [
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Dimens.fontSize_24,
                    color: textColor,
                    fontFamily: Fonts.bold),
              ),
              SizedBox(
                height: Dimens.height_20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_40),
                child: Text(
                  subText!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor,
                      fontSize: Dimens.fontSize_14,
                      fontFamily: Fonts.regular),
                ),
              ),
            ],
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
