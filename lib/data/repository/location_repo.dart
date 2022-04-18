import 'dart:ffi';

import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/helper/models/address_model..dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo extends GetxService {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  Future<Response> addAddress(AddressModel addressModal) async {
    return await apiClient.postData(
        AppConstants.ADD_USER_ADDRESS, addressModal.toJson());
  }

  Future<Response> getAllAdress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await apiClient.sharedPreferences
        .setString(AppConstants.USER_ADDRESS, userAddress);
  }
}
