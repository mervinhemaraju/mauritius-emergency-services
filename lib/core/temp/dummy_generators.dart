// Create a dummy generator for a list of Services
import 'package:mauritius_emergency_services/core/models/service.dart';

class DummyServiceGenerator {
  static List<Service> generate() {
    return [
      Service(
        identifier: "police",
        name: "Police",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "E",
        emails: [],
        mainContact: 999,
        otherContacts: [],
      ),
      Service(
        identifier: "samu",
        name: "Samu",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "E",
        emails: [],
        mainContact: 111,
        otherContacts: [],
      ),
      Service(
        identifier: "police",
        name: "Police",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "E",
        emails: [],
        mainContact: 999,
        otherContacts: [],
      ),
      Service(
        identifier: "samu",
        name: "Samu",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "E",
        emails: [],
        mainContact: 111,
        otherContacts: [],
      ),
      Service(
        identifier: "police",
        name: "Police",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "E",
        emails: [],
        mainContact: 999,
        otherContacts: [],
      ),
      Service(
        identifier: "samu",
        name: "Samu",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "E",
        emails: [],
        mainContact: 111,
        otherContacts: [],
      ),
      Service(
        identifier: "police-2",
        name: "Police 2",
        icon: "https://img.icons8.com/fluent/100/000000/policeman-male.png",
        type: "N",
        emails: [],
        mainContact: 222,
        otherContacts: [],
      ),
    ];
  }
}
