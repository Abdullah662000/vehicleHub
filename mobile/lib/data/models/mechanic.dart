import 'package:equatable/equatable.dart';

class Mechanic extends Equatable {
  const Mechanic({
    required this.id,
    required this.name,
    required this.workshop,
    required this.photo,
    required this.verified,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.distance,
    required this.brands,
    required this.services,
    required this.open,
    required this.hours,
    required this.location,
    required this.specialty,
    required this.estimate,
  });

  final String id;
  final String name;
  final String workshop;
  final String photo;
  final bool verified;
  final double rating;
  final int reviews;
  final int experience;
  final double distance;
  final List<String> brands;
  final List<String> services;
  final bool open;
  final String hours;
  final String location;
  final String specialty;
  final String estimate;

  factory Mechanic.fromJson(Map<String, dynamic> json) {
    return Mechanic(
      id: json['id'] as String,
      name: json['name'] as String,
      workshop: json['workshop'] as String,
      photo: json['photo'] as String,
      verified: json['verified'] as bool,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      experience: json['experience'] as int,
      distance: (json['distance'] as num).toDouble(),
      brands: (json['brands'] as List<dynamic>).cast<String>(),
      services: (json['services'] as List<dynamic>).cast<String>(),
      open: json['open'] as bool,
      hours: json['hours'] as String,
      location: json['location'] as String,
      specialty: json['specialty'] as String,
      estimate: json['estimate'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'workshop': workshop,
        'photo': photo,
        'verified': verified,
        'rating': rating,
        'reviews': reviews,
        'experience': experience,
        'distance': distance,
        'brands': brands,
        'services': services,
        'open': open,
        'hours': hours,
        'location': location,
        'specialty': specialty,
        'estimate': estimate,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        workshop,
        photo,
        verified,
        rating,
        reviews,
        experience,
        distance,
        brands,
        services,
        open,
        hours,
        location,
        specialty,
        estimate,
      ];
}
