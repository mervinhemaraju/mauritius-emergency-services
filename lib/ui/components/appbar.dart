import 'package:flutter/material.dart';

AppBar MesAppSearchBar({
  required SearchController searchController,
  required void Function() openDrawer,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    clipBehavior: Clip.none,
    title: SearchAnchor.bar(
      searchController: searchController,
      barHintText: "Welcome to MES",
      barElevation: WidgetStatePropertyAll(0),
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
    ),
  );
}

AppBar MesAppBar({
  required void Function() goBack,
  required String title,
}) {
  return AppBar(
    leading:
        IconButton(onPressed: goBack, icon: Icon(Icons.arrow_back_outlined)),
    title: Text(title),
  );
}
