import 'package:unibank/consts/firebase_const.dart';

class FirestoreServices {
  //For getting Users
  static getUser(uid) {
    return fireStore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }
}
