import 'package:intl/intl.dart';

class User {
  int id;
  String? name;
  String? phone;
  int createdAt;
  int updatedAt;

  User(
      {required this.id,
      this.name,
      this.phone,
      required this.createdAt,
      required this.updatedAt});

  String get stringCreateDate {
    return DateFormat('dd-MM-yyyy HH:mm').format(
      DateTime.fromMillisecondsSinceEpoch(createdAt * 1000),
    );
  }

  String get stringUpdateDate {
    return DateFormat('dd-MM-yyyy HH:mm').format(
      DateTime.fromMillisecondsSinceEpoch(updatedAt * 1000),
    );
  }
}
