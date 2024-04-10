class ApiResponse{

  int statusCode;
  dynamic bodyData;
  String? bodyString;
  String message;
  bool xSuccess;

  ApiResponse({
    required this.statusCode,
    required this.bodyData,
    required this.bodyString,
    required this.message,
    required this.xSuccess
  });

  factory ApiResponse.getInstance(){
    return ApiResponse(
      bodyData: null,
      bodyString: null,
      message: "",
      statusCode: 0,
      xSuccess: false
    );
  }

}