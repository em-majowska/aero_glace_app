import 'package:permission_handler/permission_handler.dart' as p_handler;

class PermissionService {
  Future<p_handler.PermissionStatus> checkLocationPermission() async {
    return await p_handler.Permission.locationWhenInUse.status;
  }

  Future<p_handler.PermissionStatus> requestLocationPermission() async {
    return await p_handler.Permission.locationWhenInUse.request();
  }
}
