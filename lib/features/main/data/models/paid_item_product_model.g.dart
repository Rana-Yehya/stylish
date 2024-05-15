// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_item_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidItemProductModel _$PaidItemProductModelFromJson(
        Map<String, dynamic> json) =>
    PaidItemProductModel(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      name: (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
      quantity: (json['quantity'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      colors:
          (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      size: (json['size'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PaidItemProductModelToJson(
        PaidItemProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'colors': instance.colors,
      'size': instance.size,
    };
