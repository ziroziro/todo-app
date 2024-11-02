import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widget/button.dart';
import '../../../widget/text_field.dart';
import '../../../widget/validators.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKeyLogin = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formKeyLogin,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 50.0,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Masuk Ke Akun Anda',
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
                        color: const Color(0xFF282461),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: const Color(0xFF1A1840),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 25.0,
                    ),
                    child: Column(
                      children: [
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
                        const SizedBox(height: 20),
                        TextFieldWidget(
                          prefixIcon: "assets/kata_sandi.svg",
                          hintText: 'kata sandi',
                          obscurePassword: controller.obscurePassword,
                          controller: controller.passwordController,
                          suffixIcon: controller.iconPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Password Tidak Boleh Kosong';
                            } else if (!passRexExp.hasMatch(val)) {
                              return 'Password Tidak Valid';
                            } else {
                              return null;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.offAllNamed(Routes.RESET_PASSWORD),
                  child: const Text(
                    'Lupa Kata Sandi',
                    style: TextStyle(color: Color(0xFF7B78AA)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: ButtonWidget(
                    onPressed: () {
                      if (formKeyLogin.currentState!.validate()) {
                        controller.login(controller.emailController.text,
                            controller.passwordController.text);
                      }
                    },
                    title: "Masuk",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum Punya Akun?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: Color(0xFF7B78AA)),
                      ),
                      onPressed: () {
                        Get.offNamed(Routes.REGISTER);
                      },
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

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('LoginView'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'Flutter Login Page',
//                 style: TextStyle(
//                     color: Colors.indigo,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 30),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               child: TextField(
//                 controller: controller.emailController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   labelText: 'Email',
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//               child: TextField(
//                 obscureText: true,
//                 controller: controller.passwordController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   labelText: 'Password',
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 //  Get.toNamed(Routes.RESET_PASSWORD);
//               },
//               child: const Text('Forgot Password'),
//             ),
//             Container(
//                 height: 50,
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.indigo,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                   ),
//                   child: const Text('Login'),
//                   onPressed: () => controller.login(
//                       controller.emailController.text,
//                       controller.passwordController.text),
//                 )),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Does not have an account?'),
//                 TextButton(
//                   child: const Text('Register'),
//                   onPressed: () {
//                     Get.toNamed(Routes.REGISTER);
//                   },
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
