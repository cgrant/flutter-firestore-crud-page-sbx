import 'package:uuid/uuid.dart';

class Person {
  String? id;
  String fname;
  String lname;
  String profileImageUrl;

  Person({
    this.fname = "",
    this.lname = "",
    this.id,
    this.profileImageUrl = "",
  }) {
    id ??= const Uuid().v4();
  }

  Person.fromJson(Map<String, Object?> json)
      : id = json['id']! as String,
        fname = json['fname']! as String,
        lname = json['lname']! as String,
        profileImageUrl = json['profileImageUrl']! as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fname': fname,
        'lname': lname,
        'profileImageUrl': profileImageUrl,
      };
}
