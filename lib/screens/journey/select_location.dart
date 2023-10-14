import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/location_provider.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/app_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SelectLocationScreen extends StatefulWidget {
  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  TextEditingController homeController = TextEditingController();
  TextEditingController officeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Consumer<LocationProvider>(
          builder: (context, locationStore, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackAppBar(label: Constants.travelDetails),
            SizedBox(
              height: Dimens.height_20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Constants.selectLocation,
                        style: TextStyle(
                            fontSize: Dimens.fontSize_16,
                            fontFamily: Fonts.bold,
                            color: textColor),
                      ),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      BoxTextField(
                        controller: homeController,
                        hintText: Constants.homeLocation,
                        read: true,
                        onTap: () {
                          NavigationService.navigateTo(Routes.searchLocation,
                              arguments: true);
                        },
                        suffix: Padding(
                          padding: EdgeInsets.all(Dimens.padding_15),
                          child: SvgPicture.asset(Images.pin),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      BoxTextField(
                        controller: officeController,
                        hintText: Constants.officeLocation,
                        read: true,
                        onTap: () {
                          NavigationService.navigateTo(Routes.searchLocation,
                              arguments: false);
                        },
                        suffix: Padding(
                          padding: EdgeInsets.all(Dimens.padding_15),
                          child: SvgPicture.asset(Images.pin),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      if (locationStore.homeLocation != null)
                        locationContainerTile(
                            title: locationStore.homeLocation!.address,
                            value: Constants.home),
                      SizedBox(
                        height: Dimens.height_20,
                      ),
                      if (locationStore.officeLocation != null)
                        locationContainerTile(
                            title: locationStore.officeLocation!.address,
                            value: Constants.office),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimens.padding_20),
              child: AppButton(
                label: Constants.continues,
                borderColor: textColor,
                textColor: textColor,
                backgroundColor: Colors.transparent,
                onPressed: () async {
                  // await locationStore.getRoutes(
                  //     locationStore.homeLocation!.latlng.latitude.toString(),
                  //     locationStore.homeLocation!.latlng.longitude.toString(),
                  //     locationStore.officeLocation!.latlng.latitude.toString(),
                  //     locationStore.officeLocation!.latlng.longitude
                  //         .toString());

                  getUserStore(context).addBothMarker();

                },
              ),
            )
          ],
        );
      }),
    );
  }

  getTitle(String value) {
    if (value.isEmpty) {
      return "";
    } else {
      if (value.contains(" ")) {
        String first = value.split(" ").first;
        String last = value.split(" ").last;
        return "${first[0]}${last[0]}";
      } else {
        return value[0];
      }
    }
  }

  locationContainerTile({required String title, required String value}) {
    return Container(
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
