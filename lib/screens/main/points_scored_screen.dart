import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class PointScoreScreen extends StatefulWidget {
  @override
  State<PointScoreScreen> createState() => _PointScoreScreenState();
}

class _PointScoreScreenState extends State<PointScoreScreen> {
  List<String> list = [Constants.today, Constants.monthly, Constants.yearly];
  List<String> dates = ["26 Sept 2023", "Week 1, Sept 2023", "Sept 2023"];
  List<String> points = ["08", "86", "769"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userStore, snapshot) {
      return Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            const BackAppBar(label: Constants.pointsScored),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimens.height_50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        list.length,
                        (index) {
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        list[index],
                                        style: TextStyle(
                                            color: selectedIndex == index
                                                ? distance
                                                : bottomBarInactive,
                                            fontSize: selectedIndex == index
                                                ? Dimens.fontSize_15
                                                : Dimens.fontSize_14,
                                            fontFamily: selectedIndex == index
                                                ? Fonts.bold
                                                : Fonts.regular),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: Dimens.height_3,
                                    color: selectedIndex == index
                                        ? distance
                                        : Colors.transparent,
                                    width: double.infinity,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.height_30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.padding_20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(Images.leftArrow),
                        Text(
                          dates[selectedIndex],
                          style: TextStyle(
                              color: bottomBarInactive,
                              fontSize: Dimens.fontSize_14,
                              fontFamily: Fonts.medium),
                        ),
                        SvgPicture.asset(Images.rightArrow)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimens.height_10,
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
                                points[selectedIndex],
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
                ],
              ),
            ))
          ],
        ),
      );
    });
  }
}
