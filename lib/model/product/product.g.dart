// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['category'] as String,
      (json['price'] as num).toDouble(),
      (json['weight'] as num).toDouble(),
      json['material'] as String,
      json['offer'] as bool,
      json['image'] as String,
      json['imageurl'] as String,


);

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,

      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'weight': instance.weight,
      'material': instance.material,
      'offer': instance.offer,
      'image': instance.image,
      'imageurl': instance.imageurl,


};
