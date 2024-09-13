import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  static Future<bool> requestGalleryPermission() async {
    // Check if the gallery (photos) permission is already granted
    if (false) {
      // If permission is granted, proceed with gallery access
      // _accessGallery();
      return true;
    } else {
      // Show a dialog to explain why the app needs gallery access
      bool? result = await showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text('Gallery Access Required'),
            content: const Text(
              'This app needs access to your gallery to allow you to select and upload photos. Please grant access to proceed.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Continue'),
              ),
            ],
          );
        },
      );

      if (result == true) {
        // Request permission after user agrees
        // PermissionStatus status = await Permission.photos.request();
        // _accessGallery();
        return true;
        // if (status.isGranted) {
        //   // If permission is granted, proceed with gallery access
        // } else {
        //   // If permission is denied, show a snackbar or alert
        //   _accessGallery();
        //   return true;
        // }
      }
      // _showPermissionDeniedMessage();
      return false;
    }
  }

  void _accessGallery() {
    // Implement gallery access logic here
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Gallery Access Granted')),
    );
    // Example: Open image picker or gallery browsing logic
  }

  void _showPermissionDeniedMessage() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(
          content:
              Text('Gallery access denied. Please enable it in settings.')),
    );
  }
}
