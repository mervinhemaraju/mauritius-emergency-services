import 'package:flutter/material.dart';

// TODO(Centralize all shapes and corners)
class MesShapes {
  static const chip = StadiumBorder();
  static const card = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const fab = StadiumBorder();
  static const dialog = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const searchBar = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const button = StadiumBorder();
}
