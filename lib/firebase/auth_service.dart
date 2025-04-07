import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc;

      // Check if user is student
      userDoc = await _db.collection("students").doc(uid).get();
      if (userDoc.exists) {
        return {"success": true, "role": "student", "user": userCredential.user};
      }

      // Check if user is faculty
      userDoc = await _db.collection("faculty").doc(uid).get();
      if (userDoc.exists) {
        return {"success": true, "role": "faculty", "user": userCredential.user};
      }

      // Check if user is admin (manually check credentials)
      if (email == "admin") {
        userDoc = await _db.collection("Admin").doc("ID").get();
        if (userDoc.exists && userDoc["password"] == password) {
          return {"success": true, "role": "admin"};
        }
      }

      return {"success": false, "message": "User role not found."};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
