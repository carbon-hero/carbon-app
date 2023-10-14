import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/global.dart';
import 'package:flutter_lifestyle/helper/snakbar.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/main.dart';
import 'package:flutter_lifestyle/models/location.dart';
import 'package:flutter_lifestyle/models/predictions.dart';
import 'package:flutter_lifestyle/provider/location_provider.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/app_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class SearchLocationScreen extends StatefulWidget {
  bool isHome;

  SearchLocationScreen(this.isHome);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  late GoogleMapController mapController;

  CameraPosition initialLocation = const CameraPosition(
    target: LatLng(37.0902, 95.7129),
    zoom: 6.00,
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> gpsService() async {
    _serviceEnabled = await mainLocation.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await mainLocation.requestService();
    }
    _permissionGranted = await mainLocation.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted =
          await mainLocation.requestPermission().then((value) async {
        if (value == PermissionStatus.granted) {
          mainLocation = Location();
          LocationData locationData = await mainLocation.getLocation();
          initialLocation = CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: zoom.toDouble(),
          );
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            initialLocation,
          ));
        } else {
          gpsService();
        }
      });
    } else {
      LocationData locationData = await mainLocation.getLocation();
      initialLocation = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: zoom.toDouble(),
      );
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        initialLocation,
      ));
    }
  }

  int zoom = 15;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLocationStore(context).clearMarkerList();
      gpsService();
    });
  }

  TextEditingController searchController = TextEditingController();

  Selected? selected;

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
            const BackAppBar(label: Constants.searchLocation),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    zoomControlsEnabled: false,
                    markers: Set<Marker>.of(locationStore.markerList.values),
                    myLocationButtonEnabled: false,
                    tiltGesturesEnabled: true,
                    mapToolbarEnabled: true,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: initialLocation,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimens.padding_20),
                    child: Column(
                      children: [
                        BoxTextField(
                          controller: searchController,
                          hintText: Constants.search,
                          filled: true,
                          filledColor: white,
                          suffix: Padding(
                            padding: EdgeInsets.all(Dimens.padding_15),
                            child: SvgPicture.asset(Images.search),
                          ),
                          onChanged: (value) {
                            if (value.length > 5) {
                              locationStore.getPlace(value,
                                  getUserStore(context).countryShortName);
                            } else {
                              locationStore.allPredictionList.clear();
                            }
                          },
                        ),
                        if (locationStore.allPredictionList.isNotEmpty)
                          Container(
                            padding: EdgeInsets.only(bottom: Dimens.padding_20),
                            margin: EdgeInsets.symmetric(
                                vertical: Dimens.margin_20),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius:
                                    BorderRadius.circular(Dimens.radius_7)),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: locationStore.allPredictionList.length,
                              itemBuilder: (context, index) {
                                Prediction prediction =
                                    locationStore.allPredictionList[index];
                                return InkWell(
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    await Global.getAddressFromPlaceId(
                                        prediction.placeId!,
                                        onGet: (latitude, longitude, address) {
                                      selected = Selected(
                                          address,
                                          LatLng(latitude, longitude),
                                          prediction.placeId!);
                                      MarkerId markerId =
                                          const MarkerId('location');
                                      Marker userMarker = Marker(
                                        markerId: markerId,
                                        position: LatLng(latitude, longitude),
                                        icon: getUserStore(context)
                                            .userLocationIcon!,
                                      );
                                      initialLocation = CameraPosition(
                                        target: LatLng(latitude, longitude),
                                        zoom: zoom.toDouble(),
                                      );
                                      mapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                        initialLocation,
                                      ));
                                      locationStore.addMarker(
                                          userMarker, markerId);
                                      searchController.text = address;
                                      locationStore.allPredictionList.clear();
                                      setState(() {});
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(width: Dimens.width_15),
                                      Image.asset(
                                        Images.marker,
                                        color: Colors.grey,
                                        height: Dimens.height_20,
                                      ),
                                      SizedBox(width: Dimens.width_15),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            prediction.description
                                                .toString()
                                                .split(',')
                                                .first,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: Dimens.fontSize_14,
                                                fontFamily: Fonts.semiBold,
                                                color: textColor),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            prediction.description!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: Dimens.fontSize_12,
                                                fontFamily: Fonts.medium,
                                                color: hintTextColor),
                                          ),
                                        ],
                                      )),
                                      const SizedBox(width: 15)
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(Dimens.padding_30),
                      child: AppButton(
                        label: Constants.continues,
                        onPressed: () {
                          if (selected != null) {
                            locationStore.changeLocation(
                                widget.isHome, selected!);
                            Navigator.pop(context);
                          } else {
                            AlertSnackBar.error("Please select location!");
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
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
}
