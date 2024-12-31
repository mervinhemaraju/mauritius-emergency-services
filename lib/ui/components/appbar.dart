import 'package:flutter/material.dart';

class MesAppBar extends StatelessWidget {
  final SearchController searchController;
  final void Function() openDrawer;

  const MesAppBar({
    super.key,
    required this.searchController,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: searchController,
      barHintText: "Welcome to MES",
      barElevation: WidgetStatePropertyAll(2),
      barLeading: IconButton(
        icon: const Icon(
          Icons.menu,
        ),
        // the method which is called
        // when button is pressed
        onPressed: openDrawer,
      ),
      barTrailing: [
        IconButton(
          icon: const Icon(
            Icons.clear,
          ),
          // the method which is called
          // when button is pressed
          onPressed: () => searchController.clear(),
        ),
      ],
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<Widget>.generate(
          5,
          (int index) {
            return ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              title: Text('Initial list item $index'),
            );
          },
        );
      },
    );
  }
}
