import 'package:flutter/material.dart';
import 'package:todoapp/reusable/new_screen_navigator_route.dart';
import '../services/authenticate.dart';
import '../model/account.dart';
import './home_page.dart';
import '../reusable/show_alert_snackbar.dart';
import '../services/user.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const SingleChildScrollView(
          child: RegisterPageState(),
        ));
  }
}

class RegisterPageState extends StatefulWidget {
  const RegisterPageState({Key? key}) : super(key: key);

  @override
  State<RegisterPageState> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPageState> {
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();
  final Account _account = Account();
  String? _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: const Text(
              "Register An Account",
              style: TextStyle(fontSize: 35),
            ),
          ),
          Text(
            "Almost there...",
            style:
                TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: const Text(
              "Email",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              autocorrect: false,
              controller: _emailEditingController,
              onChanged: (text) {
                setState(() {
                  _account.email = text;
                });
              },
              style: const TextStyle(fontSize: 20),
              decoration:
                  const InputDecoration(hintText: "Ex: HarryJames@gmail.com"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: const Text(
              "Username",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              autocorrect: false,
              controller: _usernameEditingController,
              onChanged: (text) {
                setState(() {
                  _account.username = text;
                });
              },
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(hintText: "Ex: Harry"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: const Text(
              "Password",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              autocorrect: false,
              obscureText: true,
              controller: _passwordEditingController,
              onChanged: (text) {
                _account.password = text;
              },
              style: const TextStyle(fontSize: 20),
              decoration:
                  const InputDecoration(hintText: "Enter your password"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: const Text(
              "Confirm Password",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextField(
              obscureText: true,
              autocorrect: false,
              controller: _confirmPasswordEditingController,
              onChanged: (text) {
                setState(() {
                  _confirmPassword = text;
                });
              },
              style: const TextStyle(fontSize: 20),
              decoration:
                  const InputDecoration(hintText: "Confirm your password"),
            ),
          ),
          InkWell(
            onTap: () async {
              ShowAlertSnackbar _snackbar = ShowAlertSnackbar();
              if (_account.email == null ||
                  _account.email == "" ||
                  _account.username == null ||
                  _account.username == "" ||
                  _account.password == null ||
                  _account.password == "") {
                _snackbar.showSnackbar(
                    context, "Please enter all required fields");
                return;
              }
              if (_confirmPassword != _account.password) {
                _snackbar.showSnackbar(context, "Password is not equal");
                return;
              }
              final _auth = AuthServices();
              final _userService = UserService();
              String _message = await _auth.registerAccount(
                  _account.email!, _account.password!);
              String _addUserMessage = await _userService.addUser(
                  _account.username!, _account.password!, _account.email!);
              if (_addUserMessage != "success") {
                _snackbar.showSnackbar(context, _addUserMessage);
                return;
              }
              if (_message != "success") {
                _snackbar.showSnackbar(context, _message);
                return;
              } else {
                _emailEditingController.clear();
                _confirmPasswordEditingController.clear();
                _passwordEditingController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.push(
                    context, NewScreenNavigatorRoute(child: const HomePage()));
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              padding:
                  const EdgeInsets.symmetric(horizontal: 117, vertical: 25),
              decoration: const BoxDecoration(
                  color: Color(0xfff96060),
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              child: const Text(
                "Let's go!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
