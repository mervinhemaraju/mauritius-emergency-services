import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/providers/notifiers/search_controller.dart';
import 'package:mauritius_emergency_services/core/providers/services.dart';
import 'package:mauritius_emergency_services/core/routes/routes.dart';
import 'package:mauritius_emergency_services/ui/theme/elevation.dart';
import 'package:mauritius_emergency_services/ui/utils/extensions.dart';

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

    // Return the view
    return SearchAnchor.bar(
        searchController: searchController,
        barHintText: "Welcome to MES",
        barElevation: WidgetStatePropertyAll(MesElevation.appBar),
        viewLeading: IconButton(
          onPressed: () {
            // searchController.clear();
            searchController.closeView("");
            context.go(ServicesRoute.path);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        onSubmitted: (query) {
          // Go to the services route
          context.go(ServicesRoute.path, extra: {
            ServicesRoute.extraQuery: query,
          });
        },
        barLeading: searchController.text.isEmpty
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: openDrawer,
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {
                  searchController.clear();
                  context.go(ServicesRoute.path);
                },
              ),
        barTrailing: [
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.clear,
              ),
              onPressed: () {
                // Clear the query
                searchController.clear();

                // If view is not open, open it
                if (!searchController.isOpen) {
                  searchController.openView();
                }
              },
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
              final filteredServices = services.search(query: query);

              // Conditional views
              if (filteredServices.isEmpty) {
                return [
                  _SearchUiNoMatch(),
                ];
              } else {
                return [
                  _SearchUiMatch(
                    services: filteredServices,
                    onTap: (service) {
                      // Udpate the search controller
                      searchController.text = service.name;

                      // Navigate to the services route
                      context.go(ServicesRoute.path, extra: {
                        ServicesRoute.extraQuery: service.name.toLowerCase(),
                      });
                    },
                  ),
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
  final void Function(Service) onTap;

  const _SearchUiMatch({
    required this.services,
    required this.onTap,
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
              onTap(services[index]);
            },
          );
        },
      ),
    );
  }
}
