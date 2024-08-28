import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_assignment/controller_binder.dart';
import 'package:google_map_assignment/ui/screen/real_time_location_tracker_screen.dart';

class GoogleMapAsssignmentApp extends StatelessWidget {
  const GoogleMapAsssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const RealTimeLocationTrackerScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
