enum ModelType {
  person,
  vehicle,
  parking,
  parkingSpace;

  String singular() => switch (this) {
        person => "Person",
        vehicle => "Vehicle",
        parking => "Parking",
        parkingSpace => "Parking Space",
      };

  String plural() => switch (this) {
        person => "People",
        vehicle => "Vehicles",
        parking => "Parkings",
        parkingSpace => "Parking Spaces",
      };

  String get resource => switch (this) {
        person => "persons",
        vehicle => "vehicles",
        parking => "parkings",
        parkingSpace => "parking-spaces",
      };
}
