import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/notifiers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';

AppBar MesAppSearchBar({
  required void Function() openDrawer,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    clipBehavior: Clip.none,
    title: _MesSearchBar(
      openDrawer: openDrawer,
    ),
  );
}

class _MesSearchBar extends ConsumerWidget {
  final void Function() openDrawer;

  const _MesSearchBar({
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the search controller
    final searchController = ref.watch(globalSearchControllerProvider);

    // Watch the services
    final services = ref.watch(servicesProvider);

    // Define the theme
    final theme = Theme.of(context);

    // Return the view
    return SearchAnchor.bar(
        searchController: searchController,
        barHintText: "Welcome to MES",
        barElevation: WidgetStatePropertyAll(MesElevation.appBar),
        barLeading: IconButton(
          icon: const Icon(
            Icons.menu,
          ),
          onPressed: openDrawer,
        ),
        barTrailing: [
          IconButton(
            icon: const Icon(
              Icons.clear,
            ),
            onPressed: () => searchController.clear(),
          ),
        ],
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return services.when(
            data: (services) {
              // Get the search query
              final query = controller.text.toLowerCase();

              if (query.isEmpty) {
                return [
                  _SearchUiInitial(),
                ];
              }

              // Get the filtered services
              final filteredServices = services
                  .where(
                    (service) =>
                        service.name.toLowerCase().contains(query) ||
                        service.mainContact.toString().contains(query),
                  )
                  .toList();

              // Conditional views
              if (filteredServices.isEmpty) {
                return [
                  _SearchUiNoMatch(),
                ];
              } else {
                return [
                  _SearchUiMatch(services: filteredServices),
                ];
              }
            },
            loading: () => [
              const Center(
                child: CircularProgressIndicator(),
              )
            ],
            error: (error, stackTrace) => [
              ListTile(
                title: Text('Error loading services'),
              )
            ],
          );
        });
  }
}

class _SearchUiInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO(Add search history functionality)
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 21.0,
                vertical: 16.0,
              ),
              child: Text("Recent Searches"),
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              child: Text("Clear"),
            ),
            SizedBox(
              width: 8.0,
            )
          ],
        ),
        SizedBox(
          height: 12.0,
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text("Something 1"),
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text("Something 2"),
        )
      ],
    );
  }
}

class _SearchUiNoMatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: 200,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Text(
              "Ooops, your query didn't match any services. Try something else?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchUiMatch extends StatelessWidget {
  final List<Service> services;

  const _SearchUiMatch({
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        itemCount: services.length,
        prototypeItem: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(services.first.name),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(services.first.mainContact.toString()),
          ),
          trailing: Icon(Icons.open_with_outlined),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(services[index].name),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(services[index].mainContact.toString()),
            ),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              // TODO(redirect to services screen with filtered value)
            },
          );
        },
      ),
    );
  }
}
