// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      company: json['company'] as String?,
      price: json['price'] as num?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      sale: json['sale'] as num?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      shoesSize: (json['shoes_size'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      color:
          (json['color'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      size: (json['size'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'company': instance.company,
      'price': instance.price,
      'description': instance.description,
      'sale': instance.sale,
      'images': instance.images,
      'shoes_size': instance.shoesSize,
      'color': instance.color,
      'category': instance.category,
      'size': instance.size,
    };
