// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartWishlistModel _$CartWishlistModelFromJson(Map<String, dynamic> json) =>
    CartWishlistModel(
      id: (json['id_table'] as num?)?.toInt(),
      userId: json['id'] as String?,
      productIds: (json['product_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isWishlist: (json['is_wishlist'] as List<dynamic>?)
          ?.map((e) => e as bool)
          .toList(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$CartWishlistModelToJson(CartWishlistModel instance) {
  final val = <String, dynamic>{
    'id': instance.userId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('product_ids', instance.productIds);
  writeNotNull('is_wishlist', instance.isWishlist);
  return val;
}
