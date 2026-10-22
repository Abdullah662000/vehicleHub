import 'package:equatable/equatable.dart';

class ServiceRecord extends Equatable {
  const ServiceRecord({
    required this.id,
    required this.title,
    required this.workshop,
    required this.mechanic,
    required this.date,
    required this.cost,
    required this.parts,
    required this.warranty,
    required this.rating,
  });

  final String id;
  final String title;
  final String workshop;
  final String mechanic;
  final String date;
  final int cost;
  final List<String> parts;
  final String warranty;
  final int rating;

  factory ServiceRecord.fromJson(Map<String, dynamic> json) {
    return ServiceRecord(
      id: json['id'] as String,
      title: json['title'] as String,
      workshop: json['workshop'] as String,
      mechanic: json['mechanic'] as String,
      date: json['date'] as String,
      cost: json['cost'] as int,
      parts: (json['parts'] as List<dynamic>).cast<String>(),
      warranty: json['warranty'] as String,
      rating: json['rating'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'workshop': workshop,
        'mechanic': mechanic,
        'date': date,
        'cost': cost,
        'parts': parts,
        'warranty': warranty,
        'rating': rating,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        workshop,
        mechanic,
        date,
        cost,
        parts,
        warranty,
        rating,
      ];
}
