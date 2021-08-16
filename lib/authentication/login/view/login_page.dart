import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_traders/authentication/services/auth.dart';
import 'package:stock_traders/authentication/signup/view/signup_page.dart';
import 'package:stock_traders/screens/home_page.dart';
import 'package:stock_traders/utils/app_utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _auth = Auth();

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
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
                  hintText: "Email",
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
                  hintText: "Password",
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
                            UserCredential user = await _auth.signIn(
                                emailController.text, passwordController.text);
                            showSnakBar(
                                context, "${user.user!.email} Signed In");
                            pushReplaceScreen(HomePage(), context);
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
                child: const Text("Log In"),
              ),
            ),
            TextButton(
              onPressed: () {
                pushReplaceScreen(SignupPage(), context);
              },
              child: Text(
                "Don't have account? Sign Up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
