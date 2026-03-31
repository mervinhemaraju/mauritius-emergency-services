import 'package:flutter/material.dart';

// TODO(Centralize all shapes and corners)
class MesShapes {
  static const card = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const fab = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const dialog = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
  static const searchBar = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
  );
  static const button = StadiumBorder();

  static const drawerItem = RoundedRectangleBorder(
    borderRadius: BorderRadius.horizontal(
      right: Radius.circular(18.0),
    ),
  );
}

class MesBorders {
  static final chip = BorderRadius.circular(8.0);
}
