import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_message.dart';
import 'package:food_delivery/controller/auth_controller.dart';
import 'package:food_delivery/controller/location_controller.dart';
import 'package:food_delivery/controller/user_controller.dart';
import 'package:food_delivery/helper/models/address_model..dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLoggedIn;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(28.4089, 77.3178), zoom: 17);
  LatLng _initialPosition = LatLng(28.4089, 77.3178);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longitude'])));

      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Page'),
        backgroundColor: AppColors.mainColor,
        elevation: 0,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = userController.userModel!.name;
            _contactPersonNumber.text = userController.userModel!.phone;
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(builder: (locationController) {
            _addressController.text =
                '${locationController.placemark.name ?? ' '}'
                '${locationController.placemark.locality ?? ' '}'
                '${locationController.placemark.postalCode ?? ' '}'
                '${locationController.placemark.country ?? ' '}';
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                        vertical: Dimensions.height10 / 2),
                    height: Dimensions.pageView / 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius15 / 3),
                      border: Border.all(width: 2, color: AppColors.mainColor),
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                          initialCameraPosition: CameraPosition(
                            target: _initialPosition,
                            zoom: 17.0,
                          ),
                          onCameraIdle: () {
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: (position) {
                            _cameraPosition = position;
                          },
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width45),
                    child: Wrap(
                      spacing: Dimensions.width45,
                      children: List.generate(
                          locationController.getAddressTypeList.length,
                          (index) {
                        return InkWell(
                          onTap: () {
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width35,
                                vertical: Dimensions.height10),
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 5,
                                  spreadRadius: 1),
                            ]),
                            child: Icon(
                              index == 0
                                  ? Icons.home
                                  : index == 1
                                      ? Icons.work
                                      : Icons.location_on,
                              color: locationController.getAddressTypeIndex ==
                                      index
                                  ? AppColors.mainColor
                                  : Colors.black54,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width45),
                    child: BigText(
                      text: "Delivery Address",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFieldWidget(
                      icon: Icons.map,
                      hintText: "Your Address",
                      controller: _addressController),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width45),
                    child: BigText(
                      text: "Name",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFieldWidget(
                      icon: Icons.person,
                      hintText: "Your name",
                      controller: _contactPersonName),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width45),
                    child: BigText(
                      text: "Mobile",
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  TextFieldWidget(
                      icon: Icons.phone,
                      hintText: "Your mobile",
                      controller: _contactPersonNumber),
                ],
              ),
            );
          });
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width45),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20)),
            ),
            child: InkWell(
              onTap: () async {
                AddressModel _addressModel = AddressModel(
                  addressType: locationController.getAddressTypeList[
                      locationController.getAddressTypeIndex],
                  contactPersonName: _contactPersonName.text,
                  contactPersonNumber: _contactPersonNumber.text,
                  address: _addressController.text,
                  latitude: locationController.position.latitude.toString(),
                  longitude: locationController.position.longitude.toString(),
                );
                locationController.addAddress(_addressModel).then((value) {
                  if (value.isSuccess) {
                    Get.offAllNamed(RouteHelper.getInitial());
                    showCustomSnackbar("Address",
                        title: "Address successfully saved",
                        color: Colors.grey);
                  } else {
                    showCustomSnackbar("Address",
                        title: "Couldn't save addres");
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.height45 * 2,
                    vertical: Dimensions.height10),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                child: Center(
                  child: BigText(
                    text: "Save Address",
                    color: Colors.white,
                    size: Dimensions.font12 * 2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
