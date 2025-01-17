import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/data/impl/runtime_permissions_impl.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/permissions_dialog.dart';
import 'package:permission_handler/permission_handler.dart';

extension NavigationExtension on BuildContext {
  void goBack() {
    if (canPop()) {
      pop();
    } else {
      go(HomeRoute.path);
    }
  }

  void navigateToPreCall(Service service, String number) async {
    // Will run this part if it is Android
    if (Platform.isAndroid) {
      // The default proceed behavior will open app settings
      Function() onProceed = () {
        openAppSettings().whenComplete(() => goBack());
      };

      // Retrieve the runtime permissions
      final runtimePermissions = RuntimePermissions();

      // Get the permission status for phone
      final phonePermissions =
          await runtimePermissions.checkPhonePermissionStatus();

      // Check if the phone permission is granted
      if (!phonePermissions.isGranted) {
        // Check if permission is permanently denied
        if (!phonePermissions.isPermanentlyDenied) {
          onProceed = () async {
            await runtimePermissions.requestPhonePermissions().whenComplete(
                  () => goBack(),
                );
          };
        }

        // Show the permissions dialog
        showDialog<String>(
          context: this,
          builder: (BuildContext context) => PermissionsDialog(
            onProceed: onProceed,
            onComplete: () => goBack(),
          ),
        );

        // End the function
        return;
      }

      // Open precall route
      push(
        PrecallRoute.path,
        extra: {
          PrecallRoute.extraService: service,
          PrecallRoute.extraNumber: number,
        },
      );
    }
  }
}

extension ServiceExtension on List<Service> {
  List<Service> search({required String query}) {
    return where(
      (service) =>
          service.name.toLowerCase().contains(query) ||
          service.mainContact.toString().contains(query) ||
          service.emails.where((email) => email.contains(query)).isNotEmpty ||
          service.otherContacts
              .where((contact) => contact.toString().contains(query))
              .isNotEmpty,
    ).toList();
  }
}

extension StringExtension on String {
  String capitalize() {
    // If the string is empty, return it as is
    if (isEmpty) return this;

    // Else capitalize the first letter and return the string
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  bool isNumeric() {
    return int.tryParse(this) != null;
  }
}

extension BytesExtensions on Uint8List? {
  Widget loadImage({
    required String networkImageUrl,
    required String memoryPlaceholderImage,
    double size = 40,
    BoxFit? fit,
  }) {
    return this == null
        ? FadeInImage.assetNetwork(
            placeholder: memoryPlaceholderImage,
            image: networkImageUrl,
            width: size,
            height: size,
            fit: fit,
          )
        : Image.memory(
            this!,
            width: size,
            height: size,
            fit: fit,
          );
  }
}
