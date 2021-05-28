import 'package:enruta/screen/myMap/address_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'addressTypeModel.dart';

class MyMapController extends GetxController {
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController _mapController;
  final address = ''.obs;
  var userlat = 0.0.obs;
  var userlong = 0.0.obs;
  var pointLat = 0.0.obs;
  var pointLong = 0.0.obs;
  var pointAddress = "".obs;

  // var cartList = List<Addres>().obs;
  // ignore: deprecated_member_use
  var addressList = List<AddressModel>().obs;
  // ignore: deprecated_member_use
  List<AddressTypeModel> addresstypeList = List<AddressTypeModel>().obs;

  AddressTypeModel selectedAddressType;

  @override
  void onInit() {
    super.onInit();

    getLocation();

    List storedCartList = GetStorage().read<List>('addressList');

    if (!storedCartList.isNull) {
      addressList =
          storedCartList.map((e) => AddressModel.fromJson(e)).toList().obs;
    }
  }

  void setaddresstype() {
    addresstypeList = [
      AddressTypeModel(1, "Current Location"),
      AddressTypeModel(2, "Home"),
      AddressTypeModel(3, "Office"),
      AddressTypeModel(4, "Other"),
      AddressTypeModel(5, "Favorite Shopping Center")
    ];
  }

  getLocation() async {
    await Future.delayed(Duration(seconds: 1));
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    userlat.value = position.latitude;
    userlong.value = position.longitude;
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    address.value = first.addressLine;
    address(first.addressLine);

    print(address);
  }

  getpointerLocation(double let, double lo) async {
    print("call api");
    print(let);
    await Future.delayed(Duration(seconds: 1));
    // ignore: unused_local_variable
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordi = new Coordinates(let, lo);
    pointLat.value = let;
    pointLong.value = lo;
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordi);

    var first = addresses.first;
    pointAddress.value = first.addressLine;
    // pointAddress(first.addressLine);

    // print(pointAddress);
  }

  getpoitlocation() {
    getpointerLocation(pointLat.value, pointLong.value);
  }

  searchandNavigate(String searchAddr) {
    Geolocator().placemarkFromAddress(searchAddr).then((result) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  result[0].position.latitude, result[0].position.longitude),
              zoom: 10.0)));
    });
  }

  void savelocation(var addrestype) {
    print(addrestype);
    AddressModel addressModel = new AddressModel();
    // List addresssList = GetStorage().read<List>('addressList');

    // addressModel.locationType = "1";

    addressModel.locationTitle = addrestype;
    String type = addrestype.toString().toLowerCase();

    if (type == "curent") {
      addressModel.locationType = "1";
      addressModel.locationTitle = "Curent Address";
      // addressModel.locationTitle = "Curent";
    }

    if (type == "home") {
      addressModel.locationType = "2";
      addressModel.locationTitle = "Home";
      // addressModel.locationTitle = "Curent";
    } else if (type == "office") {
      addressModel.locationType = "3";
      addressModel.locationTitle = "Office";
      // addressModel.locationTitle = "Home";
    } else if (type == "other") {
      addressModel.locationType = "4";
      addressModel.locationTitle = "Other";
      // addressModel.locationTitle = "Other";
    } else if (type != "home" &&
        type != "curent" &&
        type != "office" &&
        type != "other") {
      addressModel.locationType = "4";
      addressModel.locationTitle = addressModel.locationTitle;
      // addressModel.locationTitle = "Other";
    }
    if (type == null || type == "") {
      addressModel.locationTitle = "Other";
      addressModel.locationType = "4";
    }

    // if (addressList.length == 0) {
    //   addressModel.locationType = "1";
    //   addressModel.locationTitle = "Curent ";
    // } else if (addressList.length == 1) {
    //   addressModel.locationType = "2";
    //   addressModel.locationTitle = "Home";
    // } else if (addressList.length == 2) {
    //   addressModel.locationType = "3";
    //   addressModel.locationTitle = "Office";
    // } else if (addressList.length == 3) {
    //   addressModel.locationType = "4";
    //   addressModel.locationTitle = "Other";
    // } else if (addressList.length >= 4) {
    //   addressModel.locationType = "4";
    //   addressModel.locationTitle = "Other";
    // }

    addressModel.locationDetails = pointAddress.value;
    addressModel.lat = pointLat.value.toString();
    addressModel.lng = pointLong.value.toString();

    GetStorage box = GetStorage();
    addressList.add(addressModel);
    Get.back();
    box.write("addressList", addressList);
    addressList = GetStorage().read<RxList>('addressList');
    print(addressList);

    print(pointAddress.value);
    print(pointLat);
    print(pointLat);
  }
}
