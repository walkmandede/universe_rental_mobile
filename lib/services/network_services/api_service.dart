import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universe_rental/services/network_services/api_response.dart';
import '../../constants/app_functions.dart';
import 'package:dio/dio.dart' as dio;

import '../../modules/_common/controllers/c_data_controller.dart';
import '../overlays_services/dialog/dialog_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ///staging
  // String baseUrl = "https://api.nutjobs.xsphere.co/api/";

  ///local-XspherIT-2024
  // String baseUrl = "http://test.api.universerental.com/api/"; //staging
  String baseUrl = "https://test.api.universerental.com/api";
  //"http://192.168.86.176:3000/api/v1/"; //staging

  // final dioClient = dio.Dio(
  //   dio.BaseOptions(
  //     connectTimeout: const Duration(seconds: 120),
  //   )
  // );
  final getClient = GetConnect(
    timeout: const Duration(seconds: 40),
  );

  String convertNetworkImage({required String orgPath}) {
    return ApiService().baseUrl.replaceAll("api/", "api") + orgPath;
  }

  Response convertHttpResponseToGetResponse({required http.Response response}) {
    try {
      return Response(
        statusCode: response.statusCode,
        body: jsonDecode(response.body),
        bodyString: response.body,
        headers: response.headers,
      );
    } catch (e) {
      return Response(
        statusCode: response.statusCode,
        body: null,
        bodyString: response.body,
        headers: response.headers,
      );
    }
  }

  Future<Response?> get(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();

    final response = await http.get(
      Uri.parse(xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );

    return convertHttpResponseToGetResponse(response: response);

    // final response = await getClient.get(
    //   xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
    //   headers: {
    //     "accept": "*/*",
    //     "Content-Type": "application/json",
    //     if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
    //   },
    // );

    // return response;
  }

  Future<Response?> post(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();

    final response = await http.post(
      Uri.parse(xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint),
      body: jsonEncode(data),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );

    return convertHttpResponseToGetResponse(response: response);

    // final response = await getClient.post(
    //   xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
    //   jsonEncode(data),
    //   headers: {
    //     "accept": "*/*",
    //     "Content-Type": "application/json",
    //     if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
    //   },
    // );
    // return response;
  }

  Future<Response?> delete(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();

    final response = await http.delete(
      Uri.parse(xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );

    return convertHttpResponseToGetResponse(response: response);

    // final response = await getClient.delete(
    //   xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
    //   headers: {
    //     "accept": "*/*",
    //     "Content-Type": "application/json",
    //     if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
    //   },
    // );
    // return response;
  }

  Future<Response?> put(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();
    final response = await getClient.put(
      xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
      data,
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );
    return response;
  }

  Future<Response?> formDataPost(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      Map<String, dio.MultipartFile> files = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    Response? response;
    try {
      dio.Dio dioClient = dio.Dio();
      dio.FormData formData = dio.FormData.fromMap({...data, ...files});
      DataController dataController = Get.find();
      var dioResponse = await dioClient.post(
          xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
          options: dio.Options(
            contentType: 'text/html; charset=utf-8',
            headers: <String, String>{
              "accept": "*/*",
              "Content-Type": "application/json",
              if (xNeedToken)
                "Authorization": "Bearer ${dataController.apiToken}",
            },
          ),
          data: formData);
      if (dioResponse.statusCode == 201) {
        response = Response(
          statusCode: 201,
          headers: {},
          body: dioResponse.data,
          statusText: "",
        );
      }
    } catch (error) {
      if (error is dio.DioException) {
        try {
          superPrint(error.response!.data, title: error.response!.statusCode);
          response = Response(
              statusCode: error.response!.statusCode,
              body: error.response!.data,
              bodyString: error.response!.data.toString());
        } catch (e) {
          superPrint(error.toString());
          response = const Response(
              statusCode: 0, body: {}, bodyString: "Something went wrong!");
        }
      }
    }
    return response;
  }

  ApiResponse validateResponse({
    required Response? response,
  }) {
    ApiResponse apiResponse = ApiResponse.getInstance();
    if (response == null) {
      // Get.off(()=> const LoginMainPage());
      DialogService().showSnack(
          title: "Something went wrong",
          message:
              "Unable to use the system now.Please contact the development team.");
    } else {
      try {
        apiResponse.bodyString = response.bodyString;
        apiResponse.bodyData = response.body;
        apiResponse.statusCode = response.statusCode ?? 0;
        if (response.statusCode! < 200 || response.statusCode! > 299) {
          apiResponse.xSuccess = false;
        } else if (response.body["_metadata"]["statusCode"] >= 200 &&
            response.body["_metadata"]["statusCode"] <= 299) {
          //success
          apiResponse.xSuccess = true;
        } else {
          apiResponse.xSuccess = false;
        }
        apiResponse.message = response.body["message"] ?? "";
      } catch (e) {
        apiResponse.message = e.toString();
        if (response.statusCode == null) {
          // Get.off(()=> const LoginGreetingPage());
          DialogService().showSnack(
              title: "Connection Time Out",
              message:
                  "Unable to use the system now.Please contact the development team.");
        } else {
          DialogService().showSnack(
              title: "Something went wrong",
              message:
                  "Unable to use the system now.Please contact the development team.");
        }
      }
    }

    return apiResponse;
  }
}
