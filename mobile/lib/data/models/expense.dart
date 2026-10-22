import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  const Expense({
    required this.id,
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
  });

  final String id;
  final String category;
  final String title;
  final int amount;
  final String date;
  final String icon;

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      amount: json['amount'] as int,
      date: json['date'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'title': title,
        'amount': amount,
        'date': date,
        'icon': icon,
      };

  @override
  List<Object?> get props => [id, category, title, amount, date, icon];
}
