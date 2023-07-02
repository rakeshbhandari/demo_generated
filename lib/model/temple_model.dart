import 'package:hive/hive.dart';

part 'temple_model.g.dart';
@HiveType(typeId: 0)
class Mandir extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String address;

  @HiveField(2)
  String shortDescription;

  @HiveField(3)
  String priest;


 Mandir({
    // required this.id,
    required this.name,
    // required this.stateId,
    required this.address,
    required this.shortDescription,
    // required this.phone,
    required this.priest,
  });


factory Mandir.fromJson(Map<String, dynamic> json) {
    return Mandir(
      // id: json['id'],
      name: json['name'],
      // stateId: json['stateId'],
      // districtId: json['districtId'],
      // municipalityId: json['municipalityId'],
      address: json['address'],
      shortDescription: json['shortDescription'],
      // phone: json['phone'],
      priest: json['priest'],
    );
  }
}



