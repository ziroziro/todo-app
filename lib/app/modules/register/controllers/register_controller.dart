import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/myUser/myuser_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/button.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final usersCollection = FirebaseFirestore.instance.collection('users');
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;

  void register(MyUser myUser, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: myUser.email, password: password);
      Get.snackbar('Success', 'User created successfully');
      userCredential.user!.sendEmailVerification();
      try {
        MyUser user = myUser.copyWith(id: userCredential.user?.uid);
        log("User: $user");
        usersCollection.doc(user.id).set(user.toEntity().toDocument());
      } catch (e) {
        log(e.toString());
        rethrow;
      }
      Get.defaultDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
        title: 'Verifikasi Email',
        titlePadding: const EdgeInsets.only(top: 30.0),
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(25.0),
        content: Column(
          children: [
            Image.asset("assets/verification_email.png"),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'Silahkan verifikasi email Anda untuk melanjutkan. Kami telah mengirimkan tautan verifikasi.',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        cancel: ElevatedButton(
          onPressed: () {
            userCredential.user!.sendEmailVerification();
            Get.snackbar('Success', 'Email verification link sent');
          },
          style: ElevatedButton.styleFrom(
            elevation: 5,
            side: const BorderSide(
              width: 1.0,
              color: Color(0xFF7D7D7D),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                17.0,
              ),
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            "Batal",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        confirm: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 5.5,
          ),
          child: ButtonWidget(
            height: 40,
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            title: "Konfirmasi",
          ),
        ),
        confirmTextColor: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      }
      log(e.code);
    } catch (e) {
      log("$e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
