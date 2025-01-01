import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/temp/dummy_generators.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/emergency_item.dart';

class HomeScreen extends StatelessWidget {
  final SearchController searchController;
  const HomeScreen({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        clipBehavior: Clip.none,
        title: MesAppBar(
            searchController: searchController,
            openDrawer: () => _scaffoldKey.currentState?.openDrawer()),
      ),
      drawer: MesDrawer(),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Emergency call help needed?",
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Hold the emergency button to call",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: null,
                  onLongPress: () {
                    print("Emergency button clicked!");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    fixedSize: Size(200, 200),
                    shape: CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.sensors_outlined,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Need other quick emergency actions?",
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Click one below to call",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                        height: 180,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: DummyServiceGenerator.generate()
                              .map(
                                (service) => MesEmergencyItem(service: service),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
