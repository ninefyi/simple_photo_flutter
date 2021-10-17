import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class PhotoById {
  int? id;
  String? name;
  String? path;
  String? updatedAt;
  PhotoById(this.id, this.name, this.path, this.updatedAt);

  factory PhotoById.fromJson(Map<String, dynamic> json) =>
      _$PhotoByIdFromJson(json);

  Map<String, dynamic> toJson(instance) => _$PhotoByIdToJson(this);
}

@JsonSerializable()
class AllPhoto {
  late int id;
  int? memberId;
  String? memberName;
  late String name;
  late String path;
  late String updatedAt;

  AllPhoto(
    this.id,
    this.memberId,
    this.memberName,
    this.name,
    this.path,
    this.updatedAt,
  );

  factory AllPhoto.fromJson(Map<String, dynamic> json) =>
      _$AllPhotoFromJson(json);

  Map<String, dynamic> toJson(instance) => _$AllPhotoToJson(this);
}
