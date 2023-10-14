import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userStore, snapshot) {
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: Dimens.margin_100),
                  padding: EdgeInsets.only(top: Dimens.margin_70),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.radius_40),
                      topRight: Radius.circular(Dimens.radius_40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "${userStore.user!.firstName} ${userStore.user!.lastName}",
                          style: TextStyle(
                              fontSize: Dimens.fontSize_24,
                              color: textColor,
                              fontFamily: Fonts.bold),
                        ),
                        SizedBox(
                          height: Dimens.height_20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.padding_20),
                          child: Row(
                            children: [
                              Expanded(
                                child: containerTile(
                                    color: progressColor.withOpacity(0.05),
                                    icon: Images.co2,
                                    title: Constants.carbonEmission,
                                    value: "2.56 Kg"),
                              ),
                              SizedBox(
                                width: Dimens.width_20,
                              ),
                              Expanded(
                                child: containerTile(
                                    color: distance.withOpacity(0.05),
                                    icon: Images.distance,
                                    title: Constants.distanceCovered,
                                    value: "7 Km"),
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
                                    value: userStore.user!.treesPlanted.toString()),
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
                                    isBadge: true),
                              ),
                            ],
                          ),
                        ),
                        if (userStore.user!.homeAddress.isNotEmpty)
                          Column(
                            children: [
                              locationContainerTile(
                                  title: userStore.user!.homeAddress,
                                  value: Constants.home),
                              SizedBox(
                                height: Dimens.height_20,
                              ),
                            ],
                          ),
                        if (userStore.user!.officeAddress.isNotEmpty)
                          locationContainerTile(
                              title: userStore.user!.officeAddress,
                              value: Constants.office),
                        SizedBox(
                          height: Dimens.height_100,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: Dimens.margin_50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radius_60),
                child: userStore.user!.fullFileUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: userStore.user!.fullFileUrl,
                        height: Dimens.height_100,
                        width: Dimens.width_100,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            height: Dimens.height_100,
                            width: Dimens.width_100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          Images.profileDp,
                          height: Dimens.height_100,
                          width: Dimens.width_100,
                        ),
                      )
                    : Image.asset(
                        Images.profileDp,
                        height: Dimens.height_100,
                        width: Dimens.width_100,
                      ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(Dimens.padding_30),
              child: AppButton(
                label: Constants.editProfile,
                onPressed: () {
                  NavigationService.navigateTo(Routes.editProfile);
                },
              ),
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
      bool isBadge = false}) {
    return Container(
      height: Dimens.height_130,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(Dimens.radius_10)),
      padding: EdgeInsets.all(Dimens.padding_20),
      child: Stack(
        children: [
          Column(
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
          if (isBadge)
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Silver Badge",
                style: TextStyle(
                    color: textColor,
                    fontFamily: Fonts.semiBold,
                    fontSize: Dimens.fontSize_10),
              ),
            )
        ],
      ),
    );
  }

  locationContainerTile({required String title, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
      decoration: BoxDecoration(
          color: textColor.withOpacity(0.03),
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
