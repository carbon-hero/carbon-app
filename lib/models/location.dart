import 'package:google_maps_flutter/google_maps_flutter.dart';

class Selected{
  String address;
  LatLng latlng;
  String placeID;

  Selected(this.address, this.latlng,this.placeID);
}