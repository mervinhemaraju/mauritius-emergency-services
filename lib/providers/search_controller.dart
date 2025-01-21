import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/search_controller.g.dart';

@riverpod
class GlobalSearchController extends _$GlobalSearchController {
  @override
  SearchController build() {
    final controller = SearchController();

    // Add disposal callback
    ref.onDispose(() {
      controller.dispose();
    });

    return controller;
  }
}
