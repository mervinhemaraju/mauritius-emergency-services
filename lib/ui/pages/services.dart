import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/core/models/service.dart';
import 'package:mauritius_emergency_services/core/temp/dummy_generators.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/components/widgets.dart';

class ServicesScreen extends StatelessWidget {
  final SearchController searchController;
  const ServicesScreen({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final List<Service> services = DummyServiceGenerator.generate();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      body: Padding(
        padding: const EdgeInsets.only(top: 26.0),
        child: ListView(
          children:
              services.map((service) => ServiceItem(service: service)).toList(),
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final Service service;

  const ServiceItem({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      leading: FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.gif',
        image: service.icon,
        width: 48,
        height: 48,
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(service.name),
      ),
      subtitle: Row(
        spacing: 8.0,
        children: [
          Text(service.mainContact.toString()),
          MesBadge(label: "Toll Free")
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.arrow_drop_down_outlined),
      ),
    );
  }
}
