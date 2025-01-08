class Service {
  final String identifier;
  final String name;
  final String type;
  final String icon;
  final List<String> emails;
  final int mainContact;
  final List<int> otherContacts;

  const Service({
    this.identifier = "",
    this.name = "",
    this.type = "",
    this.icon = "",
    this.emails = const [],
    this.mainContact = 0,
    this.otherContacts = const [],
  });

  // Convert Service object to JSON
  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'name': name,
      'type': type,
      'icon': icon,
      'emails': emails,
      'mainContact': mainContact,
      'otherContacts': otherContacts,
    };
  }

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
