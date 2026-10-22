import 'package:equatable/equatable.dart';

enum InsuranceStatus { active, expiring, expired }

class Vehicle extends Equatable {
  const Vehicle({
    required this.id,
    required this.photo,
    required this.make,
    required this.model,
    required this.year,
    required this.reg,
    required this.mileage,
    required this.fuelType,
    required this.transmission,
    required this.insurance,
    required this.health,
    required this.color,
  });

  final String id;
  final String photo;
  final String make;
  final String model;
  final int year;
  final String reg;
  final int mileage;
  final String fuelType;
  final String transmission;
  final InsuranceStatus insurance;
  final int health;
  final String color;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      photo: json['photo'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      reg: json['reg'] as String,
      mileage: json['mileage'] as int,
      fuelType: json['fuelType'] as String,
      transmission: json['transmission'] as String,
      insurance: InsuranceStatus.values.byName(json['insurance'] as String),
      health: json['health'] as int,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'photo': photo,
        'make': make,
        'model': model,
        'year': year,
        'reg': reg,
        'mileage': mileage,
        'fuelType': fuelType,
        'transmission': transmission,
        'insurance': insurance.name,
        'health': health,
        'color': color,
      };

  @override
  List<Object?> get props => [
        id,
        photo,
        make,
        model,
        year,
        reg,
        mileage,
        fuelType,
        transmission,
        insurance,
        health,
        color,
      ];
}
