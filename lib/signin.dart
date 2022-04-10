import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  //final IAuthProvider authProvider;
  final void Function(String, String) signin;
  const SignInPage({Key? key, required this.signin}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignIn();
}

class SignIn extends State<SignInPage> {
  SignIn()
      : userController = TextEditingController(),
        passwordController = TextEditingController();

  late final Function(String, String) signin;
  TextEditingController userController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    setState(() {
      signin = widget.signin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: userController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              child: const Text("Sign In"),
              onPressed: () {
                signin(userController.text, passwordController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
