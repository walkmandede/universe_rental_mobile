// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universe_rental/constants/app_functions.dart';
import 'package:universe_rental/modules/_common/models/m_listing_tag.dart';
import 'package:universe_rental/services/network_services/api_end_points.dart';
import 'package:universe_rental/services/network_services/api_response.dart';
import 'package:universe_rental/services/network_services/api_service.dart';
import 'package:universe_rental/services/sp_services/sp_keys.dart';

class DataController extends GetxController{

  String apiToken = "";

  ValueNotifier<List<ListingTag>> allListingTags = ValueNotifier([]);
  ValueNotifier<List<String>> favoriteListingIds = ValueNotifier([]);



  Future<void> fetchListingTags() async{
    allListingTags.value.clear();
    try{
      final response = await ApiService().get(
        endPoint: ApiEndPoints.getTags,
        xNeedToken: false,
      );

      final apiResponse = ApiService().validateResponse(response: response);

      if(apiResponse.xSuccess){
        Iterable iterable = apiResponse.bodyData["_data"];
        for(final each in iterable){
          allListingTags.value.add(
            ListingTag.fromMap(data: each)
          );
        }
      }
      else{

      }
    }
    catch(e){
      null;
    }
    allListingTags.notifyListeners();
  }

  Future<void> updateSpFavorites() async{
    favoriteListingIds.value.clear();
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      favoriteListingIds.value = sharedPreferences.getStringList(SpKeys.favoriteList)??[];
    }
    catch(e){
      null;
    }
    favoriteListingIds.notifyListeners();
  }

  Future<void> toggleSpFavorites({required String listingId}) async{
    bool xIsFavorite = favoriteListingIds.value.contains(listingId);
    if(xIsFavorite){
      favoriteListingIds.value.remove(listingId);
    }
    else{
      favoriteListingIds.value.add(listingId);
    }
    favoriteListingIds.notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(SpKeys.favoriteList, favoriteListingIds.value);
    updateSpFavorites();
  }

}