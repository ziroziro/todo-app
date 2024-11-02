import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../models/myUser/myuser_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/button.dart';
import '../../../widget/text_field.dart';
import '../../../widget/validators.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

   @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController controller = Get.find<RegisterController>();
  final formKeyRegister = GlobalKey<FormState>();
  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKeyRegister,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset("assets/logo.png", height: 50.0,),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Buat Akun',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF282461),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xFF1A1840),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 25.0,
                    ),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          prefixIcon: "assets/nama.svg",
                          hintText: 'nama pengguna',
                          obscurePassword: false,
                          controller: controller.nameController,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Nama Tidak Boleh Kosong';
                            } else if (val.length > 30) {
                              return 'Nama Terlalu Panjang';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFieldWidget(
                          prefixIcon: "assets/email.svg",
                          hintText: 'email',
                          obscurePassword: false,
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                           inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[\w\-.@]+$'),
                            ),
                          ],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Email Tidak Boleh Kosong';
                            } else if (!emailRexExp.hasMatch(val)) {
                              return 'Email Tidak Valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFieldWidget(
                          prefixIcon: "assets/kata_sandi.svg",
                          hintText: 'kata sandi',
                          obscurePassword: controller.obscurePassword,
                          controller: controller.passwordController,
                          suffixIcon: controller.iconPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Kata Sandi Tidak Boleh Kosong';
                            } else if (!passRexExp.hasMatch(val)) {
                              return 'Kata Sandi Tidak Valid';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            if (val!.contains(RegExp(r'[A-Z]'))) {
                              setState(() {
                                containsUpperCase = true;
                              });
                            } else {
                              setState(() {
                                containsUpperCase = false;
                              });
                            }
                            if (val.contains(RegExp(r'[a-z]'))) {
                              setState(() {
                                containsLowerCase = true;
                              });
                            } else {
                              setState(() {
                                containsLowerCase = false;
                              });
                            }
                            if (val.contains(RegExp(r'[0-9]'))) {
                              setState(() {
                                containsNumber = true;
                              });
                            } else {
                              setState(() {
                                containsNumber = false;
                              });
                            }
                            if (val.contains(specialCharRexExp)) {
                              setState(() {
                                containsSpecialChar = true;
                              });
                            } else {
                              setState(() {
                                containsSpecialChar = false;
                              });
                            }
                            if (val.length >= 8) {
                              setState(() {
                                contains8Length = true;
                              });
                            } else {
                              setState(() {
                                contains8Length = false;
                              });
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "⚈  1 kapital",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: containsUpperCase
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  "⚈  1 huruf",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: containsLowerCase
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  "⚈  1 angka",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: containsNumber
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "⚈  1 simbol",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: containsSpecialChar
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  "⚈  8 karakter minimal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: contains8Length
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: ButtonWidget(
                    onPressed: () {
                      if (formKeyRegister.currentState!.validate()) {
                        MyUser myUser = MyUser.empty;
                        myUser = myUser.copyWith(
                          email: controller.emailController.text,
                          name: controller.nameController.text,
                          tanggalDibuat: DateTime.now(),
                        );
                        controller.register(
                          myUser,
                          controller.passwordController.text,
                        );
                      }
                    },
                    title: "Daftar",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sudah Punya Akun?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      child: const Text(
                        'Masuk',
                        style: TextStyle(color: Color(0xFF7B78AA)),
                      ),
                      onPressed: () => Get.offNamed(Routes.LOGIN),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
