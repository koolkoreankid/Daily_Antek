import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/antek.dart';
import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference and its path
  final CollectionReference antekCollection =
      Firestore.instance.collection('antek');

  Future updateUserData(String userName, int level, int points, String mood, int quoteNum) async {
    // if the document does not exist, create
    return await antekCollection.document(uid).setData({
      'userName': userName,
      'level': level,
      'points': points,
      'mood': mood,
      'quoteNum': quoteNum,
    });
  }

  //Antek List

  List<Antek> _antekListFromSnapshot(QuerySnapshot snapshot) {
    // by checking the snapshot, return modelled data of ANTEK
    return snapshot.documents.map((doc) {
      return Antek(
        userName: doc.data['userName'] ?? "unknown",
        level: doc.data['level'] ?? 1,
        points: doc.data["points"] ?? 5,
        mood: doc.data["mood"] ?? "default",
        quoteNum: doc.data["quoteNum"] ?? 0,
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      userName: snapshot.data['userName'],
      level: snapshot.data['level'],
      points: snapshot.data['points'],
      mood: snapshot.data['mood'],
      quoteNum: snapshot.data['quoteNum']
    );
  }

  // get stream when changes occur

  Stream<List<Antek>> get antek {
    return antekCollection.snapshots().map(_antekListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return antekCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
