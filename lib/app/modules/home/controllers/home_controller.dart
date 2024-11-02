import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void logout() async {
    await auth.signOut();
    Get.off(() => const LoginView());
  }
  
   Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('posts');
    return data.orderBy('time', descending: true).snapshots();
  }

  void deleteData(String docID) {
    try {
      Get.defaultDialog(
          title: "Delete Post",
          middleText: "Are you sure you want to delete this post?",
          onConfirm: () async {
            await firestore.collection('posts').doc(docID).delete();
            Get.back();
            Get.snackbar('Success', 'Data deleted successfully');
          },
          textConfirm: "Yes, I'm sure",
          textCancel: "No");
    } catch (e) {
      log("$e");
      Get.snackbar('Error', 'Cannot delete this post');
    }
  }

}
