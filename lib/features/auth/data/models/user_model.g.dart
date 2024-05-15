// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      createdAt: json['created_at'] as String?,
      image: json['image'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      emailConfirmedAt: json['emailConfirmedAt'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'lat': instance.lat,
      'lng': instance.lng,
      'emailConfirmedAt': instance.emailConfirmedAt,
    };
