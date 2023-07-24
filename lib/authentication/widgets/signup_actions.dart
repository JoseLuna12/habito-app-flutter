import 'package:flutter/material.dart';
import 'package:habito/authentication/services/auth_service.dart';
import 'package:habito/authentication/widgets/error_input_label.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/constants/app_settings.dart';

class SignupActions extends StatefulWidget {
  const SignupActions({Key? key}) : super(key: key);

  @override
  State<SignupActions> createState() => _SignupActionsState();
}

class _SignupActionsState extends State<SignupActions> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _badEmail = false;
  bool _badName = false;
  bool _badPassword = false;

  String? _emailErrorMsg;
  String? _nameErrorMsg;
  String? _passwordErrorMsg;

  void resetBadCredentials(String? label) {
    switch (label) {
      case 'email':
        setState(() {
          _badEmail = false;
          _emailErrorMsg = null;
        });
      case 'name':
        setState(() {
          _badName = false;
          _nameErrorMsg = null;
        });
      case 'password':
        setState(() {
          _badPassword = false;
          _passwordErrorMsg = null;
        });

      case _:
        setState(() {
          _badEmail = false;
          _badName = false;
          _badPassword = false;
        });
    }
  }

  bool validateInputs() {
    bool badInputs = false;
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailErrorMsg = "Email cannot be empty";
        _badEmail = true;
        badInputs = true;
      }

      if (_nameController.text.isEmpty) {
        _nameErrorMsg = "Name cannot be emtpy";
        _badName = true;
        badInputs = true;
      }

      if (_passwordController.text.isEmpty) {
        _passwordErrorMsg = "Password cannot be empty";
        _badPassword = true;
        badInputs = true;
      } else if (_passwordController.text.length <
          HabiSettings.minPasswordLength) {
        _passwordErrorMsg =
            "Password must be at least ${HabiSettings.minPasswordLength} characters";
        _badPassword = true;
        badInputs = true;
      }
    });
    return badInputs;
  }

  void linkErorsToFields(String rawErrors) {
    final errors = rawErrors.split(',');
    String? email;
    String? name;
    String? password;

    for (var err in errors) {
      final errValue = err.toLowerCase();
      if (errValue.contains('email')) {
        _badEmail = true;
        email = err;
      } else if (errValue.contains('name')) {
        _badName = true;
        name = err;
      } else if (errValue.contains('password')) {
        _badPassword = true;
        password = err;
      }
    }

    setState(() {
      _emailErrorMsg = email;
      _nameErrorMsg = name;
      _passwordErrorMsg = password;
    });
  }

  Future<void> signUpData() async {
    bool badInputs = validateInputs();
    if (badInputs) {
      return;
    }

    final String user = _emailController.text;
    final String password = _passwordController.text;
    final String name = _nameController.text;

    final res = await signup(user: user, password: password, name: name);
    if (res.hasError) {
      linkErorsToFields(res.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _emailController,
          onChanged: (_) => resetBadCredentials('email'),
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "email"),
          // enabled: !_loading,
        ),
        ErrorInputLabel(show: _badEmail, text: _emailErrorMsg ?? ''),
        TextField(
          controller: _nameController,
          onChanged: (_) => resetBadCredentials('name'),
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(hintText: "name"),
          // enabled: !_loading,
        ),
        ErrorInputLabel(show: _badName, text: _nameErrorMsg ?? ''),
        TextField(
          controller: _passwordController,
          onChanged: (_) => resetBadCredentials('password'),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "password"),
          // enabled: !_loading,
          obscureText: true,
        ),
        ErrorInputLabel(show: _badPassword, text: _passwordErrorMsg ?? ''),
        PasswordCounter(
          passwordCount: _passwordController.text.length,
        ),
        const Spacer(),
        Visibility(
          visible: keyboard < 30,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: HabiMeasurements.paddingBottomLast,
            ),
            child: ElevatedButton(
              onPressed: () => signUpData(),
              child: const Text("Sign-up"),
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class PasswordCounter extends StatelessWidget {
  late int passwordCount;

  PasswordCounter({Key? key, required this.passwordCount}) : super(key: key);

  Widget getPasswordCircle(Color color) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color inactiveColor = Theme.of(context).brightness == Brightness.light
        ? HabiColor.grayLight
        : HabiColor.blueLight;

    List<Widget> passwordIndicator =
        List.generate(HabiSettings.minPasswordLength, (index) {
      final Color currentColor =
          index < passwordCount ? HabiColor.orange : inactiveColor;
      return getPasswordCircle(currentColor);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: HabiMeasurements.paddingHorizontalXl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: passwordIndicator,
      ),
    );
  }
}
