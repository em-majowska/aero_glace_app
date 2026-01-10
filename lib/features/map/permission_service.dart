import 'package:permission_handler/permission_handler.dart';

/// Service pour gérer les permissions liées à la localisation de l'application.
class PermissionService {
  Future<PermissionStatus> checkLocationPermission() async {
    return await Permission.locationWhenInUse.status;
  }

  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.locationWhenInUse.request();
  }
}
