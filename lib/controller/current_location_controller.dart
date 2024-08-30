import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationController extends GetxController {
  Position? currentPosition;
  List<LatLng> polylineCoordinates = [];

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final bool isEnable = await Geolocator.isLocationServiceEnabled();
      if (isEnable) {
        currentPosition = await Geolocator.getCurrentPosition();
        update();

        Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.best,
              //timeLimit: Duration(seconds: 10),
              distanceFilter: 2,
            )).listen((Position newLocation) {
          currentPosition = newLocation;
          print(newLocation);
          update();

          LatLng newLatlng =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);
          polylineCoordinates.add(newLatlng);
          update();
        }
        ).onError((handleError) async {
          if(!await Geolocator.isLocationServiceEnabled()){
            await Geolocator.openLocationSettings();
          }
          getCurrentLocation();
        });
      } else {
        Geolocator.openLocationSettings();
        getCurrentLocation();
      }
    } else {
      if (permission == LocationPermission.deniedForever) {
        Geolocator.openAppSettings();
        return;
      }
      LocationPermission requestPermission =
      await Geolocator.requestPermission();
      if (requestPermission == LocationPermission.always ||
          requestPermission == LocationPermission.whileInUse) {
        getCurrentLocation();
      }
    }
  }
}
