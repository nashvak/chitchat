import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/home.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;
  RegisterPage({super.key, required this.onTap});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  void register(BuildContext context) async {
    final AuthService service = AuthService();
    try {
      await service.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
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
    );
  }
}
