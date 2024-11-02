import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController typeController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('posts').doc(docID);
    return docRef.get();
  }

  void updateData(String docID, String nama, String tipe) async {
    try {
      await firestore.collection('posts').doc(docID).update({
        'nama': nama,
        'tipe': tipe,
      });

      Get.back();
      Get.snackbar('Success', 'Data updated successfully');
    } catch (e) {
      log("$e");
      Get.snackbar('Error', 'Failed updating data');
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    typeController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    typeController.dispose();
    super.onClose();
  }
}
