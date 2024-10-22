import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam1/modal/expense_modal.dart';


class GoogleFirebaseServices {
  static GoogleFirebaseServices googleFirebaseServices = GoogleFirebaseServices._();
  GoogleFirebaseServices._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void allDataStore(Expense expense) {
    try {
      CollectionReference users = firestore.collection('expense');
      users.doc(expense.id.toString()).set(expense.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Object?>> getData() {
    Stream<QuerySnapshot> usersStream = firestore.collection('expense').snapshots();
    return usersStream;
  }
}
