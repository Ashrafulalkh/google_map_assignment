import 'package:get/get.dart';
import 'package:google_map_assignment/controller/current_location_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CurrentLocationController());
  }

}