import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController typeController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addData(String nama, String tipe) async {
    try {
      String dateNow = DateTime.now().toString();
      await firestore
          .collection('posts')
          .add({'nama': nama, 'tipe': tipe, 'time': dateNow});

      Get.back();
      Get.snackbar('Success', 'Data added successfully');
      titleController.clear();
      typeController.clear();
    } catch (e) {
      log("$e");
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
