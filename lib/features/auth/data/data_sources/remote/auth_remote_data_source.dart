import "dart:developer";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:registration/core/constants/custom_exceptions.dart";

class AuthRemoteDataSource {
  Future<void> createUser({
    required String uid,
    required String username,
    required String email,
  }) async {
    final collection = FirebaseFirestore.instance.collection("users");
    await collection.doc(uid).set({'name': username, 'email': email});
  }

  Future<Map<String, dynamic>> getUser({required String uid}) async {
    try {
      final collection = FirebaseFirestore.instance.collection("users");

      final DocumentSnapshot<Map<String, dynamic>> userDoc = await collection
          .doc(uid)
          .get();

      if (userDoc.exists) {
        return userDoc.data()??{};
      } else {
        return {};
      }
    } catch (e) {
      throw CustomException("Failed to retrieve user data: $e");
    }
  }

  Future<Map<String, dynamic>> singup({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUser(uid: res.user?.uid ?? '', username: name, email: email);
      log("result in signup is $res");
      return {"success": true, "uid": res.user?.uid};
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw CustomException("password provided is too weak.");
      } else if (e.code == "email-already-in-use") {
        throw CustomException("An account already exists with this email.");
      }
    } catch (e) {
      throw CustomException(e.toString());
    }
    return {};
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("result in signin is $res");
      return {"success": true, "uid": res.user?.uid};
    } on FirebaseAuthException catch (e) {
      log("exception login is ${e.code}");
      if (e.code == "user-not-found") {
        throw CustomException("No user found for this email.");
      } else if (e.code == "wrong-password") {
        throw CustomException("Wrong password.");
      } else if (e.code == "invalid-credential") {
        throw CustomException("Invalid credentials provided.");
      }
    } catch (e) {
      throw CustomException(e.toString());
    }
    return {};
  }
}
