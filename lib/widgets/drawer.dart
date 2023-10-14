import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/app_dialog.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/shimmer.dart';
import 'package:provider/provider.dart';

import '../helper/colors.dart';

class AppDrawer extends StatefulWidget {

  Function(int index) onTap;

  AppDrawer({required this.onTap});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Consumer<UserProvider>(builder: (context, userStore, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: accentColor,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.padding_25, vertical: Dimens.padding_45),
              child: SafeArea(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.radius_60),
                      child: userStore.user!.fullFileUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: userStore.user!.fullFileUrl,
                              height: Dimens.height_70,
                              width: Dimens.width_70,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: Dimens.height_70,
                                  width: Dimens.width_70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                Images.profileDp,
                                height: Dimens.height_70,
                                width: Dimens.width_70,
                              ),
                            )
                          : Image.asset(
                              Images.profileDp,
                              height: Dimens.height_70,
                              width: Dimens.width_70,
                            ),
                    ),
                    SizedBox(
                      width: Dimens.width_15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userStore.user!.firstName.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(bottom: Dimens.padding_3),
                            child: Text(
                              "${userStore.user!.firstName} ${userStore.user!.lastName}",
                              style: TextStyle(
                                  fontSize: Dimens.fontSize_20,
                                  color: white,
                                  fontFamily: Fonts.bold),
                            ),
                          ),
                        SizedBox(
                          height: Dimens.height_3,
                        ),
                        Text(
                          userStore.user!.email,
                          style: TextStyle(
                              fontSize: Dimens.fontSize_14,
                              color: bottomBarInactive,
                              fontFamily: Fonts.regular),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimens.height_10,
            ),
            containerTile(
                title: Constants.rewardPoints,
                onTap: () {
                  widget.onTap(0);
                  Navigator.pop(context);
                }),
            containerTile(
                title: Constants.settings,
                onTap: () {
                  widget.onTap(1);
                  Navigator.pop(context);
                }),
            containerTile(
                title: Constants.help,
                onTap: () {
                  widget.onTap(2);
                  Navigator.pop(context);
                }),
            containerTile(
              title: Constants.logout,
              onTap: () {
                Navigator.pop(context);
                AppDialog.logoutDialog(context);
              },
            )
          ],
        );
      }),
    );
  }

  containerTile({required String title, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.padding_25, vertical: Dimens.padding_20),
        child: Text(
          title,
          style:
              TextStyle(fontSize: Dimens.fontSize_14, fontFamily: Fonts.medium),
        ),
      ),
    );
  }
}
