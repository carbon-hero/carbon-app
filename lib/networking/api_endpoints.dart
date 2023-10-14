class ApiEndpoints {
  static const String signIn = '/User/Login';
  static const String register = '/User/SignUp';
  static const String verify = '/User/VerifyOTP?mobileNumber=';
  static const String user = '/User/Me';
  static const String saveUser = '/User/Save';
  static const String fileSave = '/File/Save';
  static const String getFile = '/File/Get?id=';
  static const String routes = '/Utility/GetFullMapRouteMapUrl?fromLat=';
  static const String points = '/UserPointTransactions/CheckMyBalance';
  static const String travelMode = '/DataTypes/GetAllDataTypeValue';
  static const String commuteHistory = '/CommuteHistory/Save';
  static const String addFriend = '/User/AddFriend';
  static const String appSettings = '/AppSetting/GetAll?pageNumber=1&pageSize=20';
}
