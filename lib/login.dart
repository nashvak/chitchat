import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function() onTap;
  LoginPage({super.key, required this.onTap});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login"),
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
              CustomButton(
                text: 'Login',
                ontap: () {},
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member? "),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
