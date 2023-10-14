import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/location_provider.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommutePage extends StatefulWidget {
  @override
  State<CommutePage> createState() => _CommutePageState();
}

class _CommutePageState extends State<CommutePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userStore = getUserStore(context);
      userStore.setCustomMapPin();
      userStore.gpsService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, LocationProvider>(
        builder: (context, userStore, locationStore, snapshot) {
      return Stack(
        children: [
          GoogleMap(
            onMapCreated: userStore.onMapCreated,
            markers: Set<Marker>.of(userStore.markerList.values),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            polylines: Set<Polyline>.of(userStore.polylines.values),
            tiltGesturesEnabled: true,
            mapToolbarEnabled: true,
            myLocationEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: userStore.initialLocation,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(Dimens.padding_30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (userStore.isStartJourney == false &&
                      userStore.commuteHistory != null)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: Dimens.margin_20),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(Dimens.radius_7),
                      ),
                      padding: EdgeInsets.all(Dimens.padding_15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat("E dd MMM, yyyy")
                                .format(userStore.commuteHistory!.addedOn),
                            style: TextStyle(
                              color: textColor,
                              fontFamily: Fonts.medium,
                              fontSize: Dimens.fontSize_14,
                            ),
                          ),
                          SizedBox(
                            height: Dimens.height_10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: containerTile(
                                    title: Constants.carbonEmission,
                                    value:
                                        "${userStore.commuteHistory!.carbonEmission} gm",
                                    color: progressColor.withOpacity(0.03)),
                              ),
                              SizedBox(
                                width: Dimens.width_10,
                              ),
                              Expanded(
                                child: containerTile(
                                    title: Constants.distanceCovered,
                                    value:
                                        "${userStore.commuteHistory!.distance} km",
                                    color: primaryColor.withOpacity(0.03)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimens.height_10,
                          ),
                          Text(
                            "Plant 3 trees to overcome the carbon emission",
                            style: TextStyle(
                              color: bottomBarInactive,
                              fontFamily: Fonts.medium,
                              fontSize: Dimens.fontSize_12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  AppButton(
                    label: userStore.isStartJourney
                        ? Constants.stopJourney
                        : Constants.startYourJourney,
                    backgroundColor:
                        userStore.isStartJourney ? white : primaryColor,
                    borderColor:
                        userStore.isStartJourney ? textColor : primaryColor,
                    textColor: userStore.isStartJourney ? textColor : white,
                    onPressed: () async {
                      if (userStore.isStartJourney) {
                        userStore.changeJourney(false);
                        Map<String, dynamic> params = {
                          "fromPlaceId": locationStore.homeLocation!.placeID,
                          "fromLat":
                              locationStore.homeLocation!.latlng.latitude,
                          "fromLong":
                              locationStore.homeLocation!.latlng.longitude,
                          "toPlaceId": locationStore.homeLocation!.placeID,
                          "toLat":
                              locationStore.officeLocation!.latlng.latitude,
                          "toLong":
                              locationStore.officeLocation!.latlng.longitude,
                          "modeId": userStore.travelMode!.id,
                          "typeId": userStore.travelType!.id,
                          "friendIds": userStore.friendIDs.isEmpty ? "" : userStore.friendIDs.toString().replaceAll("[", "").replaceAll("]", "")
                        };
                        await userStore.saveCommuteHistory(params);

                      } else {
                        NavigationService.navigateTo(Routes.startJourney);
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  containerTile(
      {required Color color, required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(Dimens.radius_10)),
      padding: EdgeInsets.all(Dimens.padding_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
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
    );
  }
}
