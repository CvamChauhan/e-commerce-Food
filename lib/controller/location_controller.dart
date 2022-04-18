import 'dart:convert';
import 'dart:developer';

import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/helper/models/address_model..dart';
import 'package:food_delivery/helper/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _isLoading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ['Home', 'Office', 'Other'];
  List<String> get getAddressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get getAddressTypeIndex => _addressTypeIndex;

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get isLoading => _isLoading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _isLoading = true;
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
          update();
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "Unknown location found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    } else {
      print("Error getting the google api");
    }
    return _address;
  }

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e.toString());
    }
    return _addressModel;
  }

  setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await locationRepo.addAddress(addressModel);
    if (response.statusCode == 200) {
      await getAllAddressList();
      String message = response.body['message'];
      responseModel = ResponseModel(true, message);
      saveUserAddress(addressModel);
    } else {
      print("couldn't save address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getAllAddressList() async {
    Response response = await locationRepo.getAllAdress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      List _list = response.body;
      _list.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) {
    String userAddress = jsonEncode(addressModel.toJson());
    return locationRepo.saveUserAddress(userAddress);
  }

  clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }
}
