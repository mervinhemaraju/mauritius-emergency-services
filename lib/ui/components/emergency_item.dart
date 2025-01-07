import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/data/assets_manager.dart';

class MesEmergencyItem extends StatelessWidget {
  final Service service;
  final VoidCallback onTap;

  const MesEmergencyItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 240,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                service.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FadeInImage.assetNetwork(
                  placeholder: AssetsManager.ANIMATED_LOADING,
                  image: service.icon,
                  width: 48,
                  height: 48,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
