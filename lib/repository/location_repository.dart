import 'package:flutter_lifestyle/networking/api_endpoints.dart';
import 'package:flutter_lifestyle/networking/api_response.dart';
import 'package:flutter_lifestyle/networking/dio_client.dart';

class LocationRepository {
  Future<ApiResponse?> getRoutes(
      String fromLat, String fromLong, String toLat, String toLong) async {
    return RestApiService().get("${ApiEndpoints.routes}$fromLat&fromLong=$fromLong&toLat=$toLat&toLong=$toLong");
  }
}
