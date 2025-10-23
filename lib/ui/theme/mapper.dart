import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MesColorMapper extends ColorMapper {
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  const MesColorMapper({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  });

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) {
    return switch (color) {
      const Color(0xFF000000) => primaryColor,
      const Color(0xFF000001) => secondaryColor,
      const Color(0xFF000002) => tertiaryColor,
      _ => color,
    };
  }
}
