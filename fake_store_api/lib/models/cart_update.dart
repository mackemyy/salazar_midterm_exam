import 'package:json_annotation/json_annotation.dart';

part 'cart_update.g.dart';

@JsonSerializable()
class CartUpdate {
  int? userId;
  DateTime? date;
  List<dynamic>? products;

  CartUpdate({
    this.userId,
    this.date,
    this.products,
  });

  Map<String, dynamic> toJson() => _$CartUpdateToJson(this);

  factory CartUpdate.fromJson(Map<String, dynamic> json) =>
      _$CartUpdateFromJson(json);
}
