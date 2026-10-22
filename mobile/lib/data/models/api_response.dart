import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    final rawData = json['data'];
    return ApiResponse(
      success: json['success'] as bool? ?? true,
      data: fromJsonT != null && rawData != null ? fromJsonT(rawData) : rawData as T?,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value)? toJsonT) => {
        'success': success,
        if (data != null) 'data': toJsonT != null ? toJsonT(data as T) : data,
        if (message != null) 'message': message,
        if (statusCode != null) 'statusCode': statusCode,
      };

  @override
  List<Object?> get props => [success, data, message, statusCode];
}

class ChartPoint extends Equatable {
  const ChartPoint({required this.label, required this.value});

  final String label;
  final num value;

  factory ChartPoint.fromJson(Map<String, dynamic> json) {
    return ChartPoint(
      label: json['label'] as String,
      value: json['value'] as num,
    );
  }

  Map<String, dynamic> toJson() => {'label': label, 'value': value};

  @override
  List<Object?> get props => [label, value];
}

class CategorySpend extends Equatable {
  const CategorySpend({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final num value;
  final String color;

  factory CategorySpend.fromJson(Map<String, dynamic> json) {
    return CategorySpend(
      label: json['label'] as String,
      value: json['value'] as num,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        'color': color,
      };

  @override
  List<Object?> get props => [label, value, color];
}
