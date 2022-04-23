import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/person.dart';

class PeopleRepositoryFirestore {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Person>> getAll() {
    print("in get all");
    return db.collection('people').snapshots().map(
      (snapshot) {
        print("in get all-map");
        return snapshot.docs
            .map(
              (doc) => Person(
                id: doc.data()['id'],
                fname: doc.data()['fname'],
                lname: doc.data()['lname'],
                profileImageUrl: doc.data()['profileImageUrl'],
              ),
            )
            .toList();
      },
    );
  }

  void delete(String id) {
    FirebaseFirestore.instance.collection("people").doc(id).delete();
  }

  void upsert(Person person) {
    DocumentReference doc = db.collection('people').doc(person.id);
    doc.set(person.toJson());
  }
}
