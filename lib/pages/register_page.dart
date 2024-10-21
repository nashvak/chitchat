import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;
  RegisterPage({super.key, required this.onTap});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void register(BuildContext context) async {
    final AuthService service = AuthService();
    if (passwordController.text == confirmPassController.text) {
      try {
        await service.register(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                  content: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                content: const Text("Password not match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Register"),
                const SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  text: 'Email',
                  obscure: false,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  text: 'Password',
                  obscure: true,
                  controller: passwordController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextfield(
                  text: 'Confirm Password',
                  obscure: true,
                  controller: confirmPassController,
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  text: 'Register',
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      register(context);
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Empty')));
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomePage()));
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
