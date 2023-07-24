import 'package:flutter/material.dart';
import 'package:habito/authentication/services/auth_service.dart';
import 'package:habito/authentication/widgets/error_input_label.dart';
import 'package:habito/constants/app_measurements.dart';

class LoginActions extends StatefulWidget {
  const LoginActions({Key? key}) : super(key: key);

  @override
  State<LoginActions> createState() => _LoginActionsState();
}

class _LoginActionsState extends State<LoginActions> {
  bool _loading = false;
  bool _incorrectCredentials = false;
  String _errorLoginMessage = "";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> login() async {
      setState(() {
        _loading = true;
      });

      final user = _emailController.text;
      final pass = _passwordController.text;

      final loggedUser = await loginNetwork(user, pass);

      setState(() {
        if (loggedUser.hasError) {
          _errorLoginMessage = loggedUser.message!;
          _incorrectCredentials = true;
        }
        _loading = false;
      });
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
              child: ErrorInputLabel(
            show: _incorrectCredentials,
            text: _errorLoginMessage,
          )),
        ),
        TextField(
          controller: _emailController,
          onChanged: (value) => {setState(() => _incorrectCredentials = false)},
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "email"),
          enabled: !_loading,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          onChanged: (value) => {setState(() => _incorrectCredentials = false)},
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "password"),
          enabled: !_loading,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: HabiMeasurements.paddingHorizontalXl,
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: _loading ? null : login,
              child: const Text("login"),
            ),
          ),
        ),
      ],
    );
  }
}
