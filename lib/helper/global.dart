import 'package:flutter/services.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:geocoder2/geocoder2.dart';
import 'dart:ui' as ui;

import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';

class Global{
  //get asset as byte
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static getCountryCode() async {
    var userStore = getUserStore(NavigationService.context);
    try{
      List<Placemark> address = await placemarkFromCoordinates(userStore.currentLocation!.latitude, userStore.currentLocation!.longitude);
      return address[0].isoCountryCode.toString().toLowerCase();
    }catch(e){
      var addresses = await Geocoder2.getDataFromCoordinates(latitude: userStore.currentLocation!.latitude,longitude: userStore.currentLocation!.longitude,googleMapApiKey: SharedPref.pref!.getString(Preferences.mapKey) ?? "" );
      return addresses.countryCode.toString().toLowerCase();
    }
  }

  static getAddressFromPlaceId(String placeId,
      {required Function(double, double, String) onGet}) async {
    DetailsResponse? result = await GooglePlace(Constants.mapKey).details.get(placeId);
    double lat = result!.result!.geometry!.location!.lat!;
    double lng = result.result!.geometry!.location!.lng!;
    String formattedAddress = result.result!.formattedAddress!;
    onGet(lat,lng,formattedAddress);
  }

}