import 'base_model.dart';
import 'parking_space.dart';
import 'vehicle.dart';

class Parking extends BaseModel {
  Parking({
    required super.id,
    required this.vehicle,
    required this.parkingSpace,
    required this.startTime,
    required this.endTime,
  });

  factory Parking.fromJson(Map<String, dynamic> map) {
    Vehicle? vehicle;
    if (map.containsKey("vehicle") && map["vehicle"] != null) {
      Map<String, dynamic> vehicleMap = map["vehicle"] as Map<String, dynamic>;
      vehicle = Vehicle.fromJson(vehicleMap);
    }
    ParkingSpace? parkingSpace;
    if (map.containsKey("parkingSpace") && map["parkingSpace"] != null) {
      Map<String, dynamic> parkingSpaceMap =
          map["parkingSpace"] as Map<String, dynamic>;
      parkingSpace = ParkingSpace.fromJson(parkingSpaceMap);
    }

    return Parking(
      id: map["id"] as int,
      vehicle: vehicle,
      parkingSpace: parkingSpace,
      startTime: map.containsKey("startTime")
          ? DateTime.tryParse(map["startTime"] as String) ?? DateTime.now()
          : DateTime.now(),
      endTime: map.containsKey("endTime") && map["endTime"] != null
          ? DateTime.tryParse(map["endTime"] as String)
          : null,
    );
  }

  final Vehicle? vehicle;
  final ParkingSpace? parkingSpace;
  final DateTime startTime;
  final DateTime? endTime;

  Parking copyWith({
    int? id,
    Vehicle? vehicle,
    ParkingSpace? parkingSpace,
    DateTime? startTime,
    DateTime? endTime,
    bool setVehicleToNull = false,
    bool setParkingSpaceToNull = false,
  }) {
    return Parking(
      id: id ?? this.id,
      vehicle: setVehicleToNull ? null : vehicle ?? this.vehicle,
      parkingSpace:
          setParkingSpaceToNull ? null : parkingSpace ?? this.parkingSpace,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  String toString() {
    return """Parking(
      vehicle: $vehicle,
      parkingSpace: $parkingSpace,
      startTime: $startTime,
      endTime: $endTime,)""";
  }

  @override
  bool isValid() {
    if (endTime != null) {
      return endTime!.isAfter(startTime);
    }

    return true;
  }

  double parkingCosts() {
    // TODO: modify price based on time of day?
    if (parkingSpace == null) {
      return 0;
    }

    DateTime end = endTime != null ? endTime! : DateTime.now();
    if (startTime.isAfter(end)) {
      return 0;
    }

    int elapsedHours = end.difference(startTime).inHours;
    double totalCost = parkingSpace!.pricePerHour * elapsedHours;

    return totalCost > 0 ? totalCost : 0;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "vehicle": vehicle,
      "parkingSpace": parkingSpace,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime?.toIso8601String(),
    };
  }
}