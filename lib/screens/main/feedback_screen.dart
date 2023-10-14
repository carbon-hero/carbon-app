import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/models/commute_history.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_svg/svg.dart';

import '../../helper/routes.dart';
import '../../helper/strings.dart';

class FeedbackScreen extends StatefulWidget {
  CommuteHistory? commuteHistory;

  FeedbackScreen(this.commuteHistory);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          const BackAppBar(label: Constants.feedback),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Dimens.height_20,
                  ),
                  SvgPicture.asset(
                    Images.feedback,
                  ),
                  SizedBox(
                    height: Dimens.height_40,
                  ),
                  Column(
                    children: [
                      Text(
                        Constants.feedback,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.padding_40),
                        child: Text(
                          Constants.feedbackContent,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize_14,
                              fontFamily: Fonts.regular),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_40,
                      ),
                      containerTile(
                          icon: Images.tripDuration,
                          color: distance,
                          title: Constants.tripDuration,
                          value: "24 mins."),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                        child: Row(
                          children: [
                            Expanded(
                                child: boxTile(
                                    icon: Images.co2,
                                    color: purple,
                                    title: Constants.carbonOffset,
                                    value: "${widget.commuteHistory!.carbonEmission} Kg")),
                            SizedBox(
                              width: Dimens.width_20,
                            ),
                            Expanded(
                                child: boxTile(
                                    icon: Images.distance,
                                    color: primaryColor,
                                    title: Constants.distanceCovered,
                                    value: "${widget.commuteHistory!.distance} Km")),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimens.padding_20),
            child: AppButton(
              label: Constants.submit,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  containerTile(
      {required String icon,
      required Color color,
      required String title,
      required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
      decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(Dimens.radius_7)),
      padding: EdgeInsets.all(Dimens.padding_13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.carbonOffset,
          ),
          SizedBox(
            width: Dimens.width_10,
          ),
          Text(
            title,
            style: TextStyle(
                color: bottomBarInactive,
                fontFamily: Fonts.semiBold,
                fontSize: Dimens.fontSize_12),
          ),
          const Expanded(child: SizedBox()),
          Text(
            value,
            style: TextStyle(
                color: textColor,
                fontFamily: Fonts.medium,
                fontSize: Dimens.fontSize_16),
          )
        ],
      ),
    );
  }

  boxTile(
      {required String icon,
      required Color color,
      required String title,
      required String value}) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(Dimens.radius_7)),
      padding: EdgeInsets.all(Dimens.padding_13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                color: color,
              ),
              SizedBox(
                width: Dimens.width_10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: bottomBarInactive,
                    fontFamily: Fonts.semiBold,
                    fontSize: Dimens.fontSize_12),
              ),
            ],
          ),
          SizedBox(
            height: Dimens.height_10,
          ),
          Text(
            value,
            style: TextStyle(
                color: textColor,
                fontFamily: Fonts.medium,
                fontSize: Dimens.fontSize_16),
          )
        ],
      ),
    );
  }
}
