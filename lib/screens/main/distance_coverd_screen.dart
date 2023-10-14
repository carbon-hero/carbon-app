import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DistanceCoverdScreen extends StatefulWidget {
  @override
  State<DistanceCoverdScreen> createState() => _DistanceCoverdScreenState();
}

class _DistanceCoverdScreenState extends State<DistanceCoverdScreen> {
  List<String> list = [Constants.today, Constants.monthly, Constants.yearly];
  List<String> dates = ["26 Sept 2023", "Week 1, Sept 2023", "Sept 2023"];
  List<String> titles = [Constants.today, "Week 1", "September"];
  List<String> subTitles = ["", "Week 1", "September, 2023"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userStore, snapshot) {
      return Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            const BackAppBar(label: Constants.distanceCovered),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                titles[selectedIndex],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: bottomBarInactive,
                                    fontSize: Dimens.fontSize_16,
                                    fontFamily: Fonts.medium),
                              ),
                              SizedBox(
                                height: Dimens.height_10,
                              ),
                              Text(
                                "253",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: textColor,
                                    fontFamily: Fonts.bold,
                                    fontSize: Dimens.fontSize_34),
                              ),
                              SizedBox(
                                height: Dimens.height_10,
                              ),
                              Text(
                                Constants.steps,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: progressColor,
                                    fontFamily: Fonts.bold,
                                    fontSize: Dimens.fontSize_24),
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
                    padding: EdgeInsets.only(
                        left: Dimens.padding_20, bottom: Dimens.padding_20),
                    child: Text(
                      subTitles[selectedIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: Dimens.fontSize_20,
                          fontFamily: Fonts.bold),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Dimens.padding_20),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: Dimens.height_20,
                                  width: Dimens.width_20,
                                  padding: EdgeInsets.all(Dimens.padding_3),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: distance)),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: distance),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimens.padding_20,
                                            bottom: Dimens.padding_10,
                                            top: Dimens.padding_4),
                                        child: Text(
                                          "26 Sept, 2023",
                                          style: TextStyle(
                                            color: bottomBarInactive,
                                            fontSize: Dimens.fontSize_12,
                                          ),
                                        ),
                                      ),
                                      locationContainerTile(
                                          title:
                                              "#23 Street, Downtown, California, USA",
                                          value: Constants.home)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Dimens.height_30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: Dimens.height_20,
                                  width: Dimens.width_20,
                                  padding: EdgeInsets.all(Dimens.padding_3),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: distance)),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: distance),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimens.padding_20,
                                            bottom: Dimens.padding_10,
                                            top: Dimens.padding_4),
                                        child: Text(
                                          "26 Sept, 2023",
                                          style: TextStyle(
                                            color: bottomBarInactive,
                                            fontSize: Dimens.fontSize_12,
                                          ),
                                        ),
                                      ),
                                      locationContainerTile(
                                          title:
                                              "Ocus Quantum, 5th Floor, California, USA",
                                          value: Constants.office)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimens.padding_30, top: Dimens.padding_22),
                        child: SizedBox(
                          height: Dimens.height_90,
                          child: DashLineView(
                            fillRate: 0.7,
                            direction: Axis.vertical,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      );
    });
  }

  locationContainerTile({required String title, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
      decoration: BoxDecoration(
          color: textColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(Dimens.radius_10)),
      padding: EdgeInsets.all(Dimens.padding_13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Images.pin,
          ),
          SizedBox(
            width: Dimens.width_10,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: textColor,
                  fontFamily: Fonts.regular,
                  fontSize: Dimens.fontSize_14),
            ),
          ),
          SizedBox(
            width: Dimens.width_20,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.padding_10, vertical: Dimens.padding_3),
            decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(Dimens.radius_5)),
            child: Text(
              value,
              style: TextStyle(
                  fontFamily: Fonts.medium,
                  fontSize: Dimens.fontSize_12,
                  color: white),
            ),
          )
        ],
      ),
    );
  }
}

class DashLineView extends StatelessWidget {
  final double dashHeight;
  final double dashWith;
  final Color dashColor;
  final double fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;

  DashLineView(
      {this.dashHeight = 1,
      this.dashWith = 8,
      this.dashColor = distance,
      this.fillRate = 0.5,
      this.direction = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxSize = direction == Axis.horizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();
        final dCount = (boxSize * fillRate / dashWith).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: direction,
          children: List.generate(dCount, (_) {
            return SizedBox(
              width: direction == Axis.horizontal ? dashWith : dashHeight,
              height: direction == Axis.horizontal ? dashHeight : dashWith,
              child: DecoratedBox(
                decoration: BoxDecoration(color: dashColor),
              ),
            );
          }),
        );
      },
    );
  }
}
