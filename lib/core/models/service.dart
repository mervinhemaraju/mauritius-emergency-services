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

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      identifier: json['identifier'],
      name: json['name'],
      type: json['type'],
      icon: json['icon'],
      emails: List<String>.from(json['emails']),
      mainContact: json['main_contact'],
      otherContacts: List<int>.from(json['other_contacts']),
    );
  }
}
