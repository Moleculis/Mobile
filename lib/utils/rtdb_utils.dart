import 'package:firebase_database/firebase_database.dart';

class RtdbUtils {
  static FirebaseDatabase _database = FirebaseDatabase.instance;

  static FirebaseDatabase get database => _database;

  static void setHost(String host) {
    _database = FirebaseDatabase(databaseURL: host);
  }
}
