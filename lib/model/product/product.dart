import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Products {

  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "category")
  String category;

  @JsonKey(name: "imageurl")
  String imageurl;

  @JsonKey(name: "image")
  String image;

  @JsonKey(name: "price")
  double price;

  @JsonKey(name: "weight")
  double weight;

  @JsonKey(name: "material")
  String material;

  @JsonKey(name: "offer")
  bool offer;

  Products(
      this.id,
      this.name,
      this.description,
      this.category,
      this.price,
      this.weight,
      this.material,
      this.offer,
      this.image,
      this.imageurl,

      );


  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);

}
