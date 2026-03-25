// A simple app bar that is used in some MES screens
import 'package:flutter/material.dart';

AppBar MesAppBarPrimary({
  required void Function() goBack,
  required String title,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: goBack,
      icon: const Icon(Icons.arrow_back_outlined),
    ),
    title: Text(title),
  );
}
