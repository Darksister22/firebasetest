import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final CollectionReference _database = FirebaseFirestore.instance.collection(
      'berries'); //finds a reference for a collection, or creates it if it doesn't exist.
  final String uid;
  DataBaseService({required this.uid});
  //this function will run twice. Upon registeraion it will add data to the collection, and it can be changed from the settings.
  Future updateUserData(String stnum, String name, int color) async {
    return await _database
        .doc(
            uid) //get a document  inside the collection. if the document does not exist it will create it. The UID is linked to the collection.
        .set({
      "number": stnum,
      "name": name,
      "color": color,
    });
  }
}
