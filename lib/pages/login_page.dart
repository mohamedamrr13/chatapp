import 'package:chatapp/components/custome_textfield.dart';
import 'package:chatapp/constants/constant.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/container_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool showPass = false;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formkey,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              children: [
                const SizedBox(
                  height: 90,
                ),
                SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/scholar.png')),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                      fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                    obscure: false,
                    onChanged: (data) {
                      email = data;
                    },
                    title: 'Email'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                    icon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        icon: showPass
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                    obscure: showPass,
                    onChanged: (data) {
                      password = data;
                    },
                    title: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                ContainerButton(
                    onTap: () async {
                      print('$email');
                      if (formkey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);

                          // ignore: use_build_context_synchronously
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user.');
                          }
                        }

                        isLoading = false;
                        setState(() {});
                      }
                    },
                    title: 'Sign in'),
                const SizedBox(
                  height: 8,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'dont have an account ?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("$email");
                      Navigator.pushNamed(context, RegisterPage.id,
                          arguments: email);
                    },
                    child: const Text(
                      ' Sign up',
                      style: TextStyle(
                          color: Color.fromRGBO(194, 204, 222, 0.965),
                          fontSize: 16),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
