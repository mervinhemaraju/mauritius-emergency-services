import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/welcome.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  int currentIndex = 0;
  final carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    carouselController.addListener(() {
      final position = carouselController.position;
      final width = MediaQuery.sizeOf(context).width - 32; //your width
      if (position.hasPixels) {
        final index = (position.pixels / width).round();
        setState(() {
          currentIndex = index;
        });
      }
    });
  }

// Don't forget to dispose
  @override
  void dispose() {
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 32.0,
            ),
            Text(
              "Mauritius Emergency Services",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: CarouselView(
                backgroundColor: backgroundColor,
                controller: carouselController,
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                itemExtent: MediaQuery.sizeOf(context).width,
                itemSnapping: true,
                shrinkExtent: MediaQuery.sizeOf(context).width,
                children: Welcome.welcomeItems
                    .map((item) => WelcomeCarouselItem(
                          asset: item.asset,
                          title: item.title,
                          subtitle: item.subtitle,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: currentIndex == index
                            ? 24
                            : 8, // Make active dot wider
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: theme.colorScheme.secondary,
                        ),
                      );
                    }),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    elevation: MesElevation.fab,
                    onPressed: () {
                      context.go(HomeRoute.path);
                    },
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: CircleBorder(),
                    child: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WelcomeCarouselItem extends StatelessWidget {
  final String asset;
  final String title;
  final String subtitle;

  const WelcomeCarouselItem({
    super.key,
    required this.asset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(38),
          child: Center(
            child: AspectRatio(
              aspectRatio: 1.5,
              child: SvgPicture.asset(
                asset,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 48.0,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
