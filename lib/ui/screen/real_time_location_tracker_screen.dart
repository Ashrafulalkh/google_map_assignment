import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_assignment/controller/current_location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RealTimeLocationTrackerScreen extends StatefulWidget {
  const RealTimeLocationTrackerScreen({super.key});

  @override
  State<RealTimeLocationTrackerScreen> createState() =>
      _RealTimeLocationTrackerScreenState();
}

class _RealTimeLocationTrackerScreenState
    extends State<RealTimeLocationTrackerScreen> {
  GoogleMapController? mapController;

  @override
  void initState() {
    Get.find<CurrentLocationController>().getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Real Time Location Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: GetBuilder<CurrentLocationController>(
        builder: (controller) {
          if (controller.currentPosition != null) {
            LatLng currentLatlng = LatLng(controller.currentPosition!.latitude,
                controller.currentPosition!.longitude);
            mapController?.animateCamera(CameraUpdate.newLatLng(currentLatlng));
            return GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: currentLatlng,
                zoom: 18,
              ),
              polylines: <Polyline>{
                Polyline(
                  polylineId: const PolylineId('Polyline'),
                  color: Colors.blue.shade400,
                  points: controller.polylineCoordinates,
                  width: 5,
                  jointType: JointType.round,
                  geodesic: true,
                )
              },
              markers: {
                Marker(
                    markerId: const MarkerId('Current Location'),
                    position: currentLatlng,
                    infoWindow: InfoWindow(
                      title: 'My Cureent Location',
                      snippet:
                          '${currentLatlng.latitude},${currentLatlng.longitude}',
                    ),
                    onTap: () {
                      mapController!.showMarkerInfoWindow(
                          const MarkerId('Current Location'));
                    }),
              },
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Current Location Loading'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
