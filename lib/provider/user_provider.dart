import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/global.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/snakbar.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/main.dart';
import 'package:flutter_lifestyle/models/app_settings.dart';
import 'package:flutter_lifestyle/models/commute_history.dart';
import 'package:flutter_lifestyle/models/points.dart';
import 'package:flutter_lifestyle/models/travel_mode.dart';
import 'package:flutter_lifestyle/models/user.dart';
import 'package:flutter_lifestyle/networking/api_response.dart';
import 'package:flutter_lifestyle/provider/location_provider.dart';
import 'package:flutter_lifestyle/repository/user_repository.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

UserProvider getUserStore(BuildContext context) {
  var store = Provider.of<UserProvider>(context, listen: false);
  return store;
}

class UserProvider extends ChangeNotifier {
  UserRepository repository = UserRepository();

  bool loading = false;

  bool get isLoading => loading;

  changeLoadingStatus(bool val) {
    loading = val;
    notifyListeners();
  }

  List<Contact> contacts = [];

  getContacts() async {
    changeLoadingStatus(true);
    contacts.clear();
    contacts = await ContactsService.getContacts();
    changeLoadingStatus(false);
  }

  List<int> selectedIndexList = [];

  addContact(int index) {
    selectedIndexList.add(index);
    notifyListeners();
  }

  removeContact(int index) {
    selectedIndexList.remove(index);
    notifyListeners();
  }

  List<Contact> selectedContactList() {
    List<Contact> contactList = [];
    for (var element in selectedIndexList) {
      contactList.add(contacts[element]);
    }
    return contactList;
  }

  bool isStartJourney = false;

  removePolyline() {
    polylines.clear();
    notifyListeners();
  }

  changeJourney(bool val) {
    isStartJourney = val;
    if (!val) {
      removeBothMarker();
      removePolyline();
      updateMarkerOnMap(NavigationService.context, currentLocation!);
    }
    notifyListeners();
  }

  Map<MarkerId, Marker> markerList = <MarkerId, Marker>{};

  addMarker(Marker marker, MarkerId markerId) {
    markerList[markerId] = marker;
    notifyListeners();
  }

  removeCurrentMarker() {
    markerList.removeWhere((key, marker) {
      return marker.toString().contains('user');
    });
    notifyListeners();
  }

  String countryShortName = 'in';

  Future getCountryShortName() async {
   // countryShortName = await Global.getCountryCode();
  }

  late GoogleMapController mapController;

  CameraPosition initialLocation = const CameraPosition(
    target: LatLng(37.0902, 95.7129),
    zoom: 6.00,
  );

  int zoom = 15;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  Future<void> gpsService() async {
    var userStore = getUserStore(NavigationService.context);
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
          userStore.updateMarkerOnMap(NavigationService.context,
              LatLng(locationData.latitude!, locationData.longitude!));
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            initialLocation,
          ));
          mainLocation.enableBackgroundMode(enable: true);
          mainLocation.onLocationChanged.listen((LocationData currentLocation) {
            userStore.updateMarkerOnMap(NavigationService.context,
                LatLng(currentLocation.latitude!, currentLocation.longitude!));
            initialLocation = CameraPosition(
              target:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              zoom: zoom.toDouble(),
            );
            mapController.animateCamera(CameraUpdate.newCameraPosition(
              initialLocation,
            ));
          });
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
      userStore.updateMarkerOnMap(NavigationService.context,
          LatLng(locationData.latitude!, locationData.longitude!));
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        initialLocation,
      ));
      mainLocation.enableBackgroundMode(enable: true);
      mainLocation.onLocationChanged.listen((LocationData currentLocation) {
        userStore.updateMarkerOnMap(NavigationService.context,
            LatLng(currentLocation.latitude!, currentLocation.longitude!));
        initialLocation = CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: zoom.toDouble(),
        );
        mapController.animateCamera(CameraUpdate.newCameraPosition(
          initialLocation,
        ));
      });
    }
  }

  BitmapDescriptor? userLocationIcon;
  Marker? userMarker;

  LatLng? currentLocation;

  setCustomMapPin() async {
    userLocationIcon = BitmapDescriptor.fromBytes(
        await Global.getBytesFromAsset(
            Images.userMarker,
            (MediaQuery.of(NavigationService.context).size.width * 0.1)
                .toInt()));
  }

  Future<void> updateMarkerOnMap(BuildContext context, LatLng latLng) async {
    currentLocation = latLng;
    getCountryShortName();
    MarkerId markerId = const MarkerId('user_location');
    userMarker = Marker(
      markerId: markerId,
      position: latLng,
      icon: userLocationIcon!,
    );
    addMarker(userMarker!, markerId);
  }

  User? user;

  changeUser(User user) {
    this.user = user;
    notifyListeners();
  }

  Future<void> getUser() async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.getUser();
    changeLoadingStatus(false);
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        user = User.fromJson(apiResponse.data);
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }

  Future<void> saveUser(Map<String, dynamic> params) async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.saveUser(params);
    changeLoadingStatus(false);
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        AlertSnackBar.success(apiResponse.message ?? "");
        user = User.fromJson(apiResponse.data);
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }

  String profileID = "";

  Future<void> saveFile(String type, File file) async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.saveFile(type, file);
    changeLoadingStatus(false);
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        profileID = apiResponse.data["id"].toString();
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }

  removeBothMarker() {
    markerList.removeWhere((key, marker) {
      return marker.toString().contains('home');
    });
    markerList.removeWhere((key, marker) {
      return marker.toString().contains('office');
    });
    notifyListeners();
  }

  addBothMarker() async {
    var locationStore = getLocationStore(NavigationService.context);

    BitmapDescriptor icon1 = BitmapDescriptor.fromBytes(
        await Global.getBytesFromAsset(
            Images.marker,
            (MediaQuery.of(NavigationService.context).size.width * 0.2)
                .toInt()));

    MarkerId markerId = const MarkerId('home');
    Marker marker = Marker(
      markerId: markerId,
      position: locationStore.homeLocation!.latlng,
      icon: icon1,
    );
    addMarker(marker, markerId);

    MarkerId markerId1 = const MarkerId('office');

    BitmapDescriptor icon = BitmapDescriptor.fromBytes(
        await Global.getBytesFromAsset(
            Images.toMarker,
            (MediaQuery.of(NavigationService.context).size.width * 0.2)
                .toInt()));
    Marker marker1 = Marker(
        markerId: markerId1,
        position: locationStore.officeLocation!.latlng,
        icon: icon);
    addMarker(marker1, markerId1);
    _getPolyline();

    changeJourney(true);
    Navigator.pop(NavigationService.context);
    Navigator.pop(NavigationService.context);
  }

  _getPolyline() async {
    TravelMode travelMode = TravelMode.walking;
    if (travelMode.name == "Walk") {
      travelMode = TravelMode.walking;
    } else {
      travelMode = TravelMode.driving;
    }
    List<LatLng> polylineCoordinates = [];
    var locationStore = getLocationStore(NavigationService.context);
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.mapKey,
        PointLatLng(locationStore.homeLocation!.latlng.latitude,
            locationStore.homeLocation!.latlng.longitude),
        PointLatLng(locationStore.officeLocation!.latlng.latitude,
            locationStore.officeLocation!.latlng.longitude),
        travelMode: travelMode,
        wayPoints: [
          PolylineWayPoint(location: locationStore.homeLocation!.address)
        ]);

    print(result.errorMessage);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    print(polylineCoordinates.length);
    _addPolyLine(polylineCoordinates);
  }

  Map<PolylineId, Polyline> polylines = {};

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: textColor,
        width: 5,
        points: polylineCoordinates);
    polylines[id] = polyline;
    notifyListeners();
  }

  Points? points;

  Future<void> getPoints() async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.getPoints();
    changeLoadingStatus(false);
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        points = Points.fromJson(apiResponse.data);
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }

  List<Travel> allTravelTypeList = [];

  List<Travel> travelModeList = [];
  List<Travel> travelTypeList = [];

  Travel? travelMode;
  Travel? travelType;

  Future<void> getTravelMode() async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.getTravelMode();
    changeLoadingStatus(false);
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        allTravelTypeList.clear();
        travelModeList.clear();
        travelTypeList.clear();
        apiResponse.data.forEach((element) {
          allTravelTypeList.add(Travel.fromJson(element));
        });

        for (var element in allTravelTypeList) {
          if (element.dataTypeName == "TravelMode") {
            travelModeList.add(element);
          } else {
            travelTypeList.add(element);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }

  CommuteHistory? commuteHistory;

  Future<void> saveCommuteHistory(Map<String, dynamic> params) async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.saveCommuteHistory(params);
    changeLoadingStatus(false);
    if (apiResponse != null || apiResponse!.statusCode != 404) {
      if(apiResponse.data['id'] == null){
        AlertSnackBar.error(apiResponse.message ?? "");
      }else{
        AlertSnackBar.success(apiResponse.message ?? "");
        commuteHistory = CommuteHistory.fromJson(apiResponse.data);
        NavigationService.navigateTo(Routes.feedback,arguments: commuteHistory);
      }
    }
    notifyListeners();
    try {

    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }

  List<int> friendIDs = [];

  clearFriendList() {
    friendIDs.clear();
  }

  Future<dynamic> addFriend(Map<String, dynamic> params) async {
    changeLoadingStatus(true);
    ApiResponse? apiResponse = await repository.addFriend(params);
    try {
      changeLoadingStatus(false);
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        friendIDs.add(apiResponse.data['friendId']);
        print(friendIDs);
        return "";
      }
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
      return "";
    }
  }

  AppSettings? appSettings;

  Future<void> getAllSetting() async {
    ApiResponse? apiResponse = await repository.getAllSetting();
    try {
      if (apiResponse != null || apiResponse!.statusCode != 404) {
        appSettings = AppSettings.fromJson(apiResponse.data);
        for (var element in appSettings!.items) {
          if (element.key == "GOOGLE_API_KEY") {
            SharedPref.pref!.setString(Preferences.mapKey, element.value);
            break;
          }
        }
      }
      notifyListeners();
    } catch (e) {
      changeLoadingStatus(false);
      debugPrint(e.toString());
    }
  }
}
