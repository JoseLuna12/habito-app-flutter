import 'package:flutter/material.dart';
import 'package:habito/authentication/screens/password_recovery.dart';
import 'package:habito/authentication/screens/sign_up.dart';
import 'package:habito/authentication/widgets/login_actions.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/themes/defaults.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double keyboard = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HabiMeasurements.paddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Habito",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 60,
                      fontFamily: HabiThemeDefaults.fontFamily,
                    ),
                children: const [
                  TextSpan(
                    text: ".",
                    style: TextStyle(
                      color: HabiColor.orange,
                    ),
                  ),
                ],
              ),
            ),
            const LoginActions(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PasswordRecovery(),
                    ),
                  );
                },
                child: const Text(
                  "Forgot my password",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Visibility(
              visible: keyboard == 0,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: HabiMeasurements.paddingBottomLast,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
