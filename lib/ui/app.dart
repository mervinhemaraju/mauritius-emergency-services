import 'package:flutter/material.dart';
import 'package:mauritius_emergency_services/ui/components/appbar.dart';
import 'package:mauritius_emergency_services/ui/components/drawer.dart';
import 'package:mauritius_emergency_services/ui/pages/home.dart';
import 'package:mauritius_emergency_services/ui/pages/services.dart';

class MesApp extends StatefulWidget {
  const MesApp({super.key});

  @override
  State<MesApp> createState() => MesAppState();
}

class MesAppState extends State<MesApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SearchController _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        clipBehavior: Clip.none,
        title: MesAppBar(
            searchController: _searchController,
            openDrawer: () => _scaffoldKey.currentState?.openDrawer()),
      ),
      drawer: MesDrawer(),
      body: ServicesScreen(),
    );
  }
}
