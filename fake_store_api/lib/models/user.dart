import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String username;
  String password;

  User({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
