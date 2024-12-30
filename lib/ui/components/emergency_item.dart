import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';

class MesEmergencyItem extends StatelessWidget {
  final Service service;

  const MesEmergencyItem({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 240,
        padding: EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            print("${service.name} has been clicked");
          },
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
                  placeholder: 'assets/images/loading.gif',
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
