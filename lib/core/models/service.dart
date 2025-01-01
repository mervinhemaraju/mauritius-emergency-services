class Service {
  final String identifier;
  final String name;
  final String type;
  final String icon;
  final List<String> emails;
  final int mainContact;
  final List<int> otherContacts;

  const Service({
    required this.identifier,
    required this.name,
    required this.type,
    required this.icon,
    required this.emails,
    required this.mainContact,
    required this.otherContacts,
  });
}
