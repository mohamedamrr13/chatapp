import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../components/container_button.dart';
import '../components/custome_textfield.dart';
import '../constants/constant.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'registerpage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  bool showPass = false;
  bool Loading = false;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Loading,
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
                Container(
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
                  'Sign up',
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
                      if (formkey.currentState!.validate()) {
                        Loading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          Navigator.pop(context);
                          showSnackBar(context, 'Now ,Log In');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email.');
                          }
                        }

                        Loading = false;
                        setState(() {});
                      }
                    },
                    title: 'Sign up'),
                const SizedBox(
                  height: 8,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'already have an account ?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Sign in',
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

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
