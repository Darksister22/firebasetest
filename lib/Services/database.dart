import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/models/strawmodel.dart';
import 'package:firebasetest/models/userData.dart';

class DataBaseService {
  final CollectionReference _database = FirebaseFirestore.instance.collection(
      'berries'); //finds a reference for a collection, or creates it if it doesn't exist.
  final String? uid;
  DataBaseService({this.uid});

  //this function will run twice. Upon registeraion it will add data to the collection, and it can be changed from the settings.
  Future updateUserData(String number, String name, int color) async {
    return await _database
        .doc(
            uid) //get a document  inside the collection. if the document does not exist it will create it. The UID is linked to the collection.
        .set({
      "number": number,
      "name": name,
      "color": color,
    });
  }

  //map the QuerySnapShot to a custom model.
  List<StrawBerry> _berriesFromSnap(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return StrawBerry(
          number: doc.get('number') ?? '0',
          color: doc.get('color') ?? 0,
          name: doc.get('name'));
    }).toList();
  }

  //get a snapshot of the collection, map it to custom model and return it.
  Stream<List<StrawBerry>> get berries {
    return _database.snapshots().map(_berriesFromSnap);
  }

  //get user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        color: snapshot.get('color'),
        name: snapshot.get('name'),
        number: snapshot.get('number'));
  }

  //map user data to model
  Stream<UserData> get userData {
    return _database.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
