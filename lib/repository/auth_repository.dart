import 'package:flutter_lifestyle/networking/api_endpoints.dart';
import 'package:flutter_lifestyle/networking/api_response.dart';
import 'package:flutter_lifestyle/networking/dio_client.dart';

class AuthRepository {

  Future<ApiResponse?> login(Map<String, dynamic> params) async {
    return RestApiService().post(ApiEndpoints.signIn,data: params);
  }

  Future<ApiResponse?> register(Map<String, dynamic> params) async {
    return RestApiService().post(ApiEndpoints.register,data: params);
  }

  Future<ApiResponse?> verifyOTP(String mobileNumber,String otp) async {
    return RestApiService().get("${ApiEndpoints.verify}$mobileNumber&otp=$otp");
  }

}
