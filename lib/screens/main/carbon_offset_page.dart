import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CarbonOffsetPage extends StatefulWidget {
  @override
  State<CarbonOffsetPage> createState() => _CarbonOffsetPageState();
}

class _CarbonOffsetPageState extends State<CarbonOffsetPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userStore, snapshot) {
      return Column(
        children: [
          SizedBox(
            height: Dimens.height_20,
          ),
          SizedBox(
            height: Dimens.height_250,
            child: Stack(
              children: [
                Center(
                  child: CircularPercentIndicator(
                    radius: Dimens.radius_100,
                    lineWidth: 10,
                    percent: 0.15,
                    progressColor: progressColor,
                    backgroundColor: inactiveColor.withOpacity(0.3),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Constants.today,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: bottomBarInactive,
                            fontSize: Dimens.fontSize_16,
                            fontFamily: Fonts.medium),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '253',
                          style: TextStyle(
                              color: textColor,
                              fontFamily: Fonts.bold,
                              fontSize: Dimens.fontSize_34),
                          children: <TextSpan>[
                            TextSpan(
                                text: " gm",
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: Fonts.medium,
                                    fontSize: Dimens.fontSize_24)),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Co',
                          style: TextStyle(
                              color: progressColor,
                              fontFamily: Fonts.bold,
                              fontSize: Dimens.fontSize_24),
                          children: [
                            WidgetSpan(
                              child: Transform.translate(
                                offset: const Offset(0, 3),
                                child: Text(
                                  '2',
                                  //superscript is usually smaller in size
                                  textScaleFactor: 0.7,
                                  style: TextStyle(
                                      color: progressColor,
                                      fontFamily: Fonts.bold,
                                      fontSize: Dimens.fontSize_22),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimens.height_20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
            child: Row(
              children: [
                Expanded(
                  child: containerTile(
                      color: progressColor.withOpacity(0.05),
                      icon: Images.co2,
                      title: Constants.carbonEmission,
                      value: "2.56 Kg",
                      onTap: () {
                        NavigationService.navigateTo(Routes.carbonEmission);
                      }),
                ),
                SizedBox(
                  width: Dimens.width_20,
                ),
                Expanded(
                  child: containerTile(
                      color: distance.withOpacity(0.05),
                      icon: Images.distance,
                      title: Constants.distanceCovered,
                      value: "7 Km",
                      onTap: () {
                        NavigationService.navigateTo(Routes.distanceCover);
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimens.padding_20),
            child: Row(
              children: [
                Expanded(
                  child: containerTile(
                      color: primaryColor.withOpacity(0.05),
                      icon: Images.tree,
                      title: Constants.treePlanted,
                      value: userStore.user!.treesPlanted.toString(),
                      onTap: () {
                        NavigationService.navigateTo(Routes.treePlanted);
                      }),
                ),
                SizedBox(
                  width: Dimens.width_20,
                ),
                Expanded(
                  child: containerTile(
                      color: orange.withOpacity(0.05),
                      icon: Images.point,
                      title: Constants.pointsScored,
                      value: "3",
                      onTap: () {
                        NavigationService.navigateTo(Routes.pointScore);
                      }),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  containerTile(
      {required Color color,
      required String icon,
      required String title,
      required String value,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimens.radius_10)),
        padding: EdgeInsets.all(Dimens.padding_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              height: Dimens.height_25,
              width: Dimens.width_25,
            ),
            SizedBox(
              height: Dimens.height_15,
            ),
            Text(
              title,
              style: TextStyle(
                  color: bottomBarInactive,
                  fontFamily: Fonts.semiBold,
                  fontSize: Dimens.fontSize_12),
            ),
            SizedBox(
              height: Dimens.height_5,
            ),
            Text(
              value,
              style: TextStyle(
                  color: textColor,
                  fontFamily: Fonts.medium,
                  fontSize: Dimens.fontSize_14),
            )
          ],
        ),
      ),
    );
  }
}
