abstract class MesRoute {
  static late String name;
  static late String path;
}

final class WelcomeRoute extends MesRoute {
  static const String name = 'Welcome';
  static const String path = '/welcome';
}

final class DisclaimerRoute extends MesRoute {
  static const String name = 'Disclaimer';
  static const String path = '/disclaimer';
}

final class HomeRoute extends MesRoute {
  static const String name = 'Home';
  static const String path = '/';
}

final class PrecallRoute extends MesRoute {
  static const String name = 'PreCall';
  static const String path = '/precall';
  static const String extraService = "service";
  static const String extraNumber = "number";
}

final class ServicesRoute extends MesRoute {
  static const String name = 'Services';
  static const String path = '/services';
  static const String extraQuery = "query";
}

final class CycloneReportRoute extends MesRoute {
  static const String name = 'CycloneReport';
  static const String path = '/cyclone_report';
}

final class AboutRoute extends MesRoute {
  static const String name = 'About';
  static const String path = '/about';
}

final class SettingsRoute extends MesRoute {
  static const String name = 'Settings';
  static const String path = '/settings';
}
