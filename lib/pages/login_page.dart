import 'package:flutter/material.dart';
import './forgot_password_page.dart';
import './home_page.dart';
import '../animation/new_screen_navigator_route.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const LoginPageState());
  }
}

class LoginPageState extends StatefulWidget {
  const LoginPageState({Key? key}) : super(key: key);

  @override
  State<LoginPageState> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPageState> {
  final _usernameEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();
  void _moveToPreviousScreen() {
    Navigator.of(context, rootNavigator: true).pop(context);
  }

  void _openForgotPasswordPage() {
    Navigator.push(
        context, NewScreenNavigatorRoute(child: const ForgotPasswordPage()));
  }

  void _openHomePage() {
    Navigator.push(context, NewScreenNavigatorRoute(child: const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 35),
              ),
              Text(
                "Sign in to continue...",
                style: TextStyle(
                    fontSize: 15, color: Colors.black.withOpacity(0.6)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Username",
                  style: TextStyle(
                    fontSize: 25,
                  )),
              TextField(
                autocorrect: false,
                controller: _usernameEditingController,
                onChanged: (text) {},
                decoration: const InputDecoration(
                  hintText: 'Harry James',
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text("Password",
                  style: TextStyle(
                    fontSize: 25,
                  )),
              TextField(
                autocorrect: false,
                controller: _passwordEditingController,
                onChanged: (text) {},
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: _openForgotPasswordPage,
                    child: const Text(
                      "Forgot password ?",
                      style:
                          TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _openHomePage();
                    },
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 24),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Color(0xfff96060)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 108, vertical: 15),
                    child: TextButton(
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
        onWillPop: () async {
          _moveToPreviousScreen();
          return true;
        });
  }
}
