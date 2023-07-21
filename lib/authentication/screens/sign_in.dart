import 'package:flutter/material.dart';
import 'package:habito/constants/app_colors.dart';
import 'package:habito/constants/app_measurements.dart';
import 'package:habito/themes/defaults.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double keyboard = MediaQuery.of(context).viewInsets.bottom;
    bool incorrectCredentials = false;

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: SizedBox(
                  height: 25,
                  child: Visibility(
                    visible: incorrectCredentials,
                    child: Text(
                      "Incorrect email / password",
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
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "email"),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "password"),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: HabiMeasurements.paddingHorizontalXl,
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("login"),
                ),
              ),
            ),
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
