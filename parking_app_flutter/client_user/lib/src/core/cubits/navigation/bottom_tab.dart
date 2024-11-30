import 'package:flutter/material.dart';

enum BottomTab {
  parkings,
  vehicles,
  people,
  profile,
  settings;

  factory BottomTab.fromIndex(int index) => switch (index) {
        0 => parkings,
        1 => vehicles,
        2 => people,
        3 => profile,
        _ => settings,
      };

  static BottomTab get defaultTab => parkings;

  String get label => switch (this) {
        parkings => "Parkings",
        vehicles => "Vehicles",
        people => "People",
        profile => "Profile",
        settings => "Settings",
      };

  IconData get icon => switch (this) {
        parkings => Icons.local_parking_outlined,
        vehicles => Icons.car_rental_outlined,
        people => Icons.people_outline,
        profile => Icons.person_outline,
        settings => Icons.settings_outlined,
      };

  IconData get selectedIcon => switch (this) {
        parkings => Icons.local_parking_rounded,
        vehicles => Icons.car_rental_rounded,
        people => Icons.people_rounded,
        profile => Icons.person_rounded,
        settings => Icons.settings_rounded,
      };
}
