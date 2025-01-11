import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';

extension NavigationExtension on BuildContext {
  void goBack() {
    if (canPop()) {
      pop();
    } else {
      go(HomeRoute.path);
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
