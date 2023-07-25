import 'package:flutter/material.dart';
import 'package:habito/features/authentication/services/auth_service.dart';
import 'package:habito/features/authentication/services/user_local.dart';
import 'package:habito/features/authentication/widgets/error_input_label.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/features/timeline/screens/home.dart';

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

  Future<void> login() async {
    setState(() {
      _loading = true;
    });

    final user = _emailController.text;
    final pass = _passwordController.text;

    final loggedUser = await loginNetwork(user, pass);

    if (loggedUser.hasError) {
      setState(() {
        _loading = false;
        _errorLoginMessage = loggedUser.message!;
        _incorrectCredentials = true;
      });
      return;
    }

    await saveUser(loggedUser.data!);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
