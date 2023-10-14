import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PointsPage extends StatefulWidget {
  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserStore(context).getPoints();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,userStore, snapshot) {
        return Column(
          children: [
            SizedBox(
              height: Dimens.height_20,
            ),
            SizedBox(
              height: Dimens.height_250,
              width: Dimens.height_250,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      Images.point2,
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          Images.shadow1,
                          width: Dimens.width_40,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          Images.shadow3,
                          height: Dimens.width_40,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          Images.shadow5,
                          width: Dimens.width_40,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          Images.shadow7,
                          height: Dimens.width_40,
                        ),
                      ),
                    ],
                  ),
                  Transform.rotate(
                    angle: -math.pi / 4,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            Images.shadow1,
                            width: Dimens.width_40,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            Images.shadow3,
                            height: Dimens.width_40,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            Images.shadow5,
                            width: Dimens.width_40,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            Images.shadow7,
                            height: Dimens.width_40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      Images.point1,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Dimens.height_55,
                          width: Dimens.height_55,
                          padding: EdgeInsets.all(Dimens.padding_10),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.circular(Dimens.radius_15)),
                          child: SvgPicture.asset(
                            Images.point,
                            color: progressColor,
                          ),
                        ),
                        SizedBox(
                          height: Dimens.height_15,
                        ),
                        Text(
                          Constants.totalPoints,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: white,
                              fontSize: Dimens.fontSize_18,
                              fontFamily: Fonts.regular),
                        ),
                        Text(
                          userStore.points!.balance.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: white,
                              fontSize: Dimens.fontSize_34,
                              fontFamily: Fonts.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimens.height_40,
            ),
            containerTile(
                bgColor: primaryColor.withOpacity(0.05),
                color: primaryColor,
                value: userStore.points!.earned.toString(),
                title: Constants.pointsScoredToday),
            SizedBox(
              height: Dimens.height_20,
            ),
            containerTile(
                bgColor: orange.withOpacity(0.05),
                color: orange,
                value: userStore.points!.spent.toString(),
                title: Constants.pointsScoredLastMonth),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.all(Dimens.padding_30),
              child: AppButton(
                label: "${Constants.redeemPoints} (${userStore.points!.balance})",
                onPressed: () {},
              ),
            )
          ],
        );
      }
    );
  }

  containerTile(
      {required Color bgColor,
      required Color color,
      required String title,
      required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimens.radius_10)),
      padding: EdgeInsets.all(Dimens.padding_13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimens.height_45,
            width: Dimens.width_45,
            padding: EdgeInsets.all(Dimens.padding_10),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(Dimens.radius_7)),
            child: SvgPicture.asset(
              Images.point,
              color: white,
            ),
          ),
          SizedBox(
            width: Dimens.width_10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: bottomBarInactive,
                    fontFamily: Fonts.semiBold,
                    fontSize: Dimens.fontSize_12),
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
        ],
      ),
    );
  }
}
