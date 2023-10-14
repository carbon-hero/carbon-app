import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class TreePlantScreen extends StatefulWidget {
  @override
  State<TreePlantScreen> createState() => _TreePlantScreenState();
}

class _TreePlantScreenState extends State<TreePlantScreen> {
  List<String> list = [Constants.today, Constants.monthly, Constants.yearly];
  List<String> dates = ["26 Sept 2023", "Week 1, Sept 2023", "Sept 2023"];

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
                  containerTile(
                      bgColor: distance.withOpacity(0.05),
                      icon: Images.distance,
                      value: "7 km",
                      title: Constants.distanceCovered),
                  SizedBox(
                    height: Dimens.height_20,
                  ),
                  containerTile(
                      bgColor: primaryColor.withOpacity(0.05),
                      icon: Images.tree,
                      value: userStore.user!.treesPlanted.toString(),
                      title: Constants.treeToBePlanted),
                  SizedBox(
                    height: Dimens.height_20,
                  ),
                  containerTile(
                      bgColor: progressColor.withOpacity(0.05),
                      icon: Images.co2,
                      value: "8%",
                      title: Constants.carbonEmissionReducedBy),
                ],
              ),
            ))
          ],
        ),
      );
    });
  }

  containerTile(
      {required Color bgColor,
        required String icon,
        required String title,
        required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimens.radius_10)),
      padding: EdgeInsets.all(Dimens.padding_15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                icon,
                width: Dimens.width_20,
                height: Dimens.height_20,
              ),
              SizedBox(
                width: Dimens.width_15,
              ),
              Text(
                title,
                style: TextStyle(
                    color: bottomBarInactive,
                    fontFamily: Fonts.bold,
                    fontSize: Dimens.fontSize_14),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: Dimens.padding_35),
            child: Text(
              value,
              style: TextStyle(
                  color: textColor,
                  fontFamily: Fonts.semiBold,
                  fontSize: Dimens.fontSize_20),
            ),
          )
        ],
      ),
    );
  }

}
