import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          width: 120,
          height: 120,
          AssetsManager.STATIC_ERROR,
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary, BlendMode.srcIn),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 32.0, top: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
