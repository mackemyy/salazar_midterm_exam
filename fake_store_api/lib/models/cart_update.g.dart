// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartUpdate _$CartUpdateFromJson(Map<String, dynamic> json) => CartUpdate(
      userId: json['userId'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      products: json['products'] as List<dynamic>?,
    );

Map<String, dynamic> _$CartUpdateToJson(CartUpdate instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'date': instance.date?.toIso8601String(),
      'products': instance.products,
    };
