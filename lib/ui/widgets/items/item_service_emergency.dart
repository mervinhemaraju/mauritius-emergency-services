import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service/service.dart';
import 'package:mauritius_emergency_services/data/helpers/assets_manager.dart';
import 'package:mauritius_emergency_services/ui/theme/shapes.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

class MesEmergencyTileItem extends StatelessWidget {
  final MesService service;
  final Function()? onTap;

  const MesEmergencyTileItem({
    required this.service,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tintedSurface(level: 8.0),
      shape: MesShapes.card,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                service.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: service.iconData.loadImage(
                  networkImageUrl: service.icon,
                  memoryPlaceholderImage: AssetsManager.animatedLoading,
                  size: 48,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
