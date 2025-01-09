import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

class RotatingSvg extends StatefulWidget {
  // The rotation duration
  final Duration duration;

  const RotatingSvg({
    super.key,
    required this.duration,
  });

  @override
  RotatingSvgState createState() => RotatingSvgState();
}

class RotatingSvgState extends State<RotatingSvg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration, // Adjust rotation speed here
      vsync: this,
    )..repeat(); // This makes it rotate indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi, // Full 360° rotation
          child: SvgPicture.asset(
            width: 160,
            height: 160,
            AssetsManager.STATIC_CYCLONE,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}
