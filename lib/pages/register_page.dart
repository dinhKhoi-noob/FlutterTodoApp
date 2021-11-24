import 'package:flutter/material.dart';

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
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _confirmPasswordEditingController = TextEditingController();

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
              onChanged: (text) {},
              style: const TextStyle(
                fontSize: 20
              ),
              decoration: const InputDecoration(hintText: "HarryJames@gmail.com"),
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
              onChanged: (text) {},
              style: const TextStyle(
                fontSize: 20
              ),
              decoration: const InputDecoration(hintText: "Enter your password"),
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
              onChanged: (text) {},
              style: const TextStyle(
                fontSize: 20
              ),
              decoration: const InputDecoration(hintText: "Confirm your password"),
            ),
          ),
          InkWell(
            onTap: (){},
            child: Container(
              margin: const EdgeInsets.only(top:40),
              padding: const EdgeInsets.symmetric(horizontal: 117,vertical: 25),
              decoration: const BoxDecoration(
                color: Color(0xfff96060),
                borderRadius: BorderRadius.all(Radius.circular(7))
              ),
              child: const Text(
                "Let's go!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
