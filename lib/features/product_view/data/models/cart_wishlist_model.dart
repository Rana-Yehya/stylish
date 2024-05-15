import 'package:json_annotation/json_annotation.dart';

part 'cart_wishlist_model.g.dart';

@JsonSerializable()
class CartWishlistModel {
  @JsonKey(includeToJson: false, includeFromJson: true, name: 'id_table')
  int? id;
  //user_id
  @JsonKey(name: "id")
  String? userId;
  //product_ids
  @JsonKey(includeToJson: true, includeIfNull: false, name: "product_ids")
  List<int>? productIds;
  @JsonKey(includeToJson: false, includeFromJson: false)
  int? productId;
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? isProductinWishlist;
  @JsonKey(includeToJson: true, includeIfNull: false, name: "is_wishlist")
  List<bool>? isWishlist;
  @JsonKey(includeToJson: false, name: "created_at")
  String? createdAt;

  CartWishlistModel({
    this.id,
    this.userId,
    this.productIds,
    this.productId,
    this.isProductinWishlist,
    this.isWishlist,
    this.createdAt,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory CartWishlistModel.fromJson(Map<String, dynamic> json) =>
      _$CartWishlistModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CartWishlistModelToJson(this);
}
