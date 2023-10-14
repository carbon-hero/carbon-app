class ApiResponse<T> {
  int? statusCode;
  T? data;
  String? message;
  String? errors;

  ApiResponse({this.statusCode, this.data, this.message = "", this.errors});

  @override
  String toString() {
    return "StatusCode : $statusCode \n Message : $message \n Errors : $errors \n Data : $data";
  }
}

