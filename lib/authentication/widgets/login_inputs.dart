import 'package:flutter/material.dart';
import 'package:habito/authentication/services/auth_service.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';

class LoginInputs extends StatefulWidget {
  const LoginInputs({Key? key}) : super(key: key);

  @override
  _LoginInputsState createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  bool incorrectCredentials = false;
  bool _loading = false;
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

      if (loggedUser.hasError) {
        setState(() {
          _errorLoginMessage = loggedUser.message!;
          incorrectCredentials = true;
        });
      }

      setState(() {
        _loading = false;
      });
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: SizedBox(
              height: 25,
              child: Visibility(
                visible: incorrectCredentials,
                child: Text(
                  _errorLoginMessage,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? HabiColor.dangerLight
                        : HabiColor.dangerDark,
                    // color:  HabiColor.dangerDark,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
        TextField(
          controller: _emailController,
          onChanged: (value) => {setState(() => incorrectCredentials = false)},
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "email"),
          enabled: !_loading,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          onChanged: (value) => {setState(() => incorrectCredentials = false)},
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
