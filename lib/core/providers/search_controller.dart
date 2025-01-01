import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalSearchController extends StateNotifier<SearchController> {
  GlobalSearchController() : super(SearchController());

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final globalSearchControllerProvider =
    StateNotifierProvider<GlobalSearchController, SearchController>(
        (ref) => GlobalSearchController());
