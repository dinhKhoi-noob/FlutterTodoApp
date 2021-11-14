import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

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
              Navigator.of(context).pop(context);
            },
          ),
        ),
        body: const ForgotPasswordPageState());
  }
}

class ForgotPasswordPageState extends StatefulWidget {
  const ForgotPasswordPageState({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPageState> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPageState> {
  final _emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Forgot your password",
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          Text(
            "Type your email to reset your password",
            style:TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 16
            )
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Email Address",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          TextField(
            autocorrect: false,
            controller: _emailEditingController,
            onChanged: (value){},
            style: const TextStyle(
              fontSize: 20
            ),
            decoration: const InputDecoration(
              hintText: "example@mail.com"
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 75,vertical: 15),
                child: TextButton(
                  child: const Text(
                    "Send Request",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),
                  onPressed: (){
                    //Send request to user email
                  },
                ),
                decoration: const BoxDecoration(
                  color: Color(0xfff96060),
                  borderRadius: BorderRadius.all(Radius.circular(7))
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
