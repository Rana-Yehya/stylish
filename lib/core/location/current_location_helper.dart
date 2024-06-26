import 'package:dartz/dartz.dart';
import 'package:stylish/core/models/static/failure.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  LocationHelper();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Either<Failure, Position>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    bool serviceOpened;
    // Test if location services are enabled.

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceOpened = await Geolocator.openLocationSettings();
      if (!serviceOpened)
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Left(Failure(messege: "Location services are disabled."));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Left(Failure(messege: 'Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Left(
        Failure(
          messege:
              'Location permissions are permanently denied, we cannot request permissions.',
        ),
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Right(await Geolocator.getCurrentPosition());
  }
}
