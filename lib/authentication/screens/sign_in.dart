import 'package:flutter/material.dart';
import 'package:habito/authentication/services/auth_service.dart';
import 'package:habito/authentication/widgets/login_inputs.dart';
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
            const LoginInputs(),
            Center(
              child: TextButton(
                onPressed: () {},
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
                    onPressed: () {},
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
