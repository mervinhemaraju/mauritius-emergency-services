import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

// The cyclone news item
class CycloneNewsItem extends StatelessWidget {
  final String news;

  const CycloneNewsItem({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: MesElevation.card,
      child: Container(
        width: 260.0,
        padding: const EdgeInsets.all(8.0),
        child: Text(news),
      ),
    );
  }
}
