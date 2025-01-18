import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_controller.g.dart';

@riverpod
class GlobalSearchController extends _$GlobalSearchController {
  @override
  SearchController build() => SearchController();
}
