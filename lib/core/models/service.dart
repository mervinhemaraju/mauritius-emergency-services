class Service {
  String identifier = "";
  String name = "";
  String type = "";
  String icon = "";
  List<String> emails = [];
  int mainContact = 0;
  List<int> otherContacts = [];

  Service({
    required this.identifier,
    required this.name,
    required this.type,
    required this.icon,
    required this.emails,
    required this.mainContact,
    required this.otherContacts,
  });
}
