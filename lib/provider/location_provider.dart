import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/models/location.dart';
import 'package:flutter_lifestyle/models/predictions.dart';
import 'package:flutter_lifestyle/networking/api_response.dart';
import 'package:flutter_lifestyle/repository/location_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

LocationProvider getLocationStore(BuildContext context) {
  var store = Provider.of<LocationProvider>(context, listen: false);
  return store;
}

class LocationProvider extends ChangeNotifier {

  LocationRepository repository = LocationRepository();

  bool loading = false;

  bool get isLoading => loading;

  changeLoadingStatus(bool val) {
    loading = val;
    notifyListeners();
  }

  getPlace(String query,String shortName) async {
    print(shortName);
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&sensor=false&key=${Constants.mapKey}&language=en";
    print(url);
    await getPrediction(url);
  }

  List<Prediction> allPredictionList = [];

  //get prediction list
  Future<dynamic> getPrediction(String url) async {
    try {
      var response = await Dio().get(url);

      allPredictionList.clear();
      List<Prediction> predictionList = [];
      print(response.data);
      if(response.data['status'] == 'OK'){
        response.data['predictions'].forEach((element) {
          predictionList.add(Prediction.fromJson(element));
        });
      }
      allPredictionList.addAll(predictionList);
      notifyListeners();
      return predictionList;
    } catch (e) {
      return e;
    }
  }

  Map<MarkerId, Marker> markerList = <MarkerId, Marker>{};

  addMarker(Marker marker, MarkerId markerId) {
    markerList[markerId] = marker;
    notifyListeners();
  }

  clearMarkerList(){
    markerList.clear();
    notifyListeners();
  }

  Selected? homeLocation;
  Selected? officeLocation;

  changeLocation(bool isHome,Selected location){
    if(isHome){
      homeLocation = location;
    }else{
      officeLocation = location;
    }
    notifyListeners();
  }

  Future<void> getRoutes(String fromLat, String fromLong, String toLat, String toLong) async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.getRoutes(fromLat,fromLong,toLat,toLong);
    changeLoadingStatus(false);
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {

      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }



}