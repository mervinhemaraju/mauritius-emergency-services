import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/models/about.dart';
import 'package:mauritius_emergency_services/models/service.dart';
import 'package:mauritius_emergency_services/routes/routes.dart';
import 'package:mauritius_emergency_services/data/impl/runtime_permissions_impl.dart';
import 'package:mauritius_emergency_services/generated/translations/strings.g.dart';
import 'package:mauritius_emergency_services/ui/pages/welcome/permissions_dialog.dart';
import 'package:mauritius_emergency_services/ui/utils/constants.dart';
import 'package:pair/pair.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String capitalizeAll() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  bool isNumeric() {
    return int.tryParse(this) != null;
  }

  List<Pair<String, String>> getStyleHeaderName() {
    // Split the name
    final names = split(" ");

    // Return the formated name
    return names.map((name) {
      // First check if the name is empty
      if (length < 2) return Pair(name, name);

      return Pair(name[0].toUpperCase(), name.substring(1).toLowerCase());
    }).toList();
  }
}

extension BytesExtensions on Uint8List? {
  Widget? loadImage({
    required String networkImageUrl,
    required String memoryPlaceholderImage,
    double size = 40,
    BoxFit? fit,
  }) {
    if (this == null && networkImageUrl.isEmpty) {
      return null;
    }

    return this == null
        ? CachedNetworkImage(
            placeholder: (context, url) => Image.asset(
              memoryPlaceholderImage,
              width: size,
              height: size,
              fit: fit,
            ),
            // image: networkImageUrl,
            imageUrl: networkImageUrl,
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

extension AboutExtensions on About {
  void launchAboutIntent() async {
    if (title.toLowerCase().startsWith(
          t.pages.about.support_section
              .share_app_title(
                app_name_short: t.app.short_name,
              )
              .toLowerCase(),
        )) {
      // TODO(After launched on app store, change this URL to app store for IOS)
      Share.share(URI_MES_PLAYSTORE);
    } else {
      if (url != null) {
        await launchUrl(url!);
      }
    }
  }
}

extension SnackbarExtensions on BuildContext {
  void showSimpleSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

extension ViewAnimations on Widget {
  CustomTransitionPage withSlideTransition(LocalKey pageKey) {
    return CustomTransitionPage(
      key: pageKey,
      child: this,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  CustomTransitionPage withScaleTransition(LocalKey pageKey) {
    return CustomTransitionPage(
      key: pageKey,
      child: this,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.95,
            end: 1.0,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
