import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_traders/authentication/login/view/login_page.dart';
import 'package:stock_traders/authentication/services/auth.dart';
import 'package:stock_traders/utils/app_utils.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Auth _auth = Auth();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Signup",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: !pressed
                    ? () async {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          setState(() {
                            pressed = true;
                          });
                          try {
                            UserCredential user = await _auth.signUp(
                                emailController.text, passwordController.text);
                            showSnakBar(
                                context, "${user.user!.email} Signed Up");
                            pushReplaceScreen(LoginPage(), context);
                          } catch (e) {
                            String error = e.toString();
                            showSnakBar(context,
                                error.substring(error.indexOf(']') + 2));
                          } finally {
                            setState(() {
                              pressed = false;
                            });
                          }
                        } else {
                          showSnakBar(context, "Please fill all the fields");
                        }
                      }
                    : null,
                child: const Text("Sign Up"),
              ),
            ),
            TextButton(
              onPressed: () {
                pushReplaceScreen(LoginPage(), context);
              },
              child: Text(
                "Already have account? Log In",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
